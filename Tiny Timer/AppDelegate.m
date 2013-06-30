//
//  AppDelegate.m
//  Tiny Timer
//
//  Created by River Jiang on 2013-06-30.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

//  TODO prettier interface, instead of using default menu dropdown
//  TODO nicer indication of whether the timer/countdown is running than using the play/pause unicode characters (which are way too bold for the job) -- is it possible to have images alongside the text label?

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize statusBar, startPauseMenuItem, stopwatchMenuItem, countdownMenuItem, countdownDurationMenuItem, statusMenu;

- (void) awakeFromNib {
	//	init menubar
	self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	self.statusBar.menu = statusMenu;
	[statusMenu setAutoenablesItems:NO];
	self.statusBar.highlightMode = YES;
	[stopwatchMenuItem setState:NSOnState];
	
	//	init stopwatch object
	//  stopwatchMode == YES -> stopwatch
	//  stopwatchMode == NO -> countdown
	stopwatchMode = YES;
	stopwatch = [[Timer alloc] init];
	
	//  default countdown duration: 30 min
	[stopwatch setCountdownDuration:1800];
	
	//	update menubar display with time
	[self updateStatusBar];
	[self updateCountdownDurationMenu];
}

- (void) updateStatusBar {
	//	NSString *statusIcon;
	//	if ([stopwatch running]) {
	//		statusIcon = @"▶";
	//	} else {
	//		statusIcon = @"❚❚";
	//	}
	//	
	//	self.statusBar.title = [NSString stringWithFormat:@"%@ %@", statusIcon, [stopwatch formatTimeElapsed:[stopwatch secondsElapsed]] ];
	
	if (stopwatchMode) {
		self.statusBar.title = [stopwatch formatTime:[stopwatch secondsElapsed]];
	} else {
		self.statusBar.title = [stopwatch formatTime:[stopwatch countdownSecondsRemaining]];
	}
}

- (void) updateCountdownDurationMenu {
	self.countdownDurationMenuItem.title = [NSString stringWithFormat:@"↳ from %@", [stopwatch formatTime:[stopwatch countdownDuration]]];
}

- (IBAction)stopwatchStartPause:(id)sender {
	if (!stopwatchTimer) {
        // start timer
        [stopwatch startTimer];
        stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateStatusBar) userInfo:nil repeats:YES];
		[startPauseMenuItem setTitle:@"Pause"];
    } else {
        // pause timer
        [stopwatch pauseTimer];
		[self updateStatusBar];
        [stopwatchTimer invalidate];
        stopwatchTimer = nil;
		[startPauseMenuItem setTitle:@"Resume"];
    }
}

- (IBAction)stopwatchReset:(id)sender {
	[stopwatch resetTimer];
    
    if (stopwatchTimer) {
        [stopwatchTimer invalidate];
        stopwatchTimer = nil;
    }
    
    [self updateStatusBar];
	[startPauseMenuItem setTitle:@"Start"];
}

- (IBAction)stopwatchMenuClicked:(id)sender {
	[stopwatchMenuItem setState:NSOnState];
	[countdownMenuItem setState:NSOffState];
	[countdownDurationMenuItem setEnabled:NO];
	stopwatchMode = YES;
	[self updateStatusBar];
}

- (IBAction)countdownMenuClicked:(id)sender {
	[stopwatchMenuItem setState:NSOffState];
	[countdownMenuItem setState:NSOnState];
	[countdownDurationMenuItem setEnabled:YES];
	stopwatchMode = NO;
	[self updateStatusBar];
}

- (NSString *)input: (NSString *)prompt defaultValue: (NSString *)defaultValue {
	NSAlert *alert = [NSAlert alertWithMessageText:prompt
									 defaultButton:@"OK"
								   alternateButton:@"Cancel"
									   otherButton:nil
						 informativeTextWithFormat:@""];
	
	NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 300, 24)];
	[input setStringValue:defaultValue];
	[alert setAccessoryView:input];
	NSInteger button = [alert runModal];
	if (button == NSAlertDefaultReturn) {
		[input validateEditing];
		return [input stringValue];
	} else if (button == NSAlertAlternateReturn) {
		return nil;
	} else {
		return nil;
	}
}

- (IBAction)countdownDurationMenuClicked:(id)sender {
	NSString *input = [self input:@"Set countdown duration (seconds)" defaultValue:[NSString stringWithFormat:@"%.f", [stopwatch countdownDuration]]];
	[stopwatch setCountdownDuration:[input doubleValue]];
	[self updateCountdownDurationMenu];
	[self updateStatusBar];
}
@end
