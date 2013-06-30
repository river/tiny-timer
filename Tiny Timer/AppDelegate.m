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
@synthesize statusBar, startPauseMenuItem, stopwatchMenuItem, countdownMenuItem;

- (void) awakeFromNib {
	//	init menubar
	self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	self.statusBar.menu = self.statusMenu;
	self.statusBar.highlightMode = YES;
	[stopwatchMenuItem setState:NSOnState];
	
	//	init stopwatch object
	//  stopwatchMode == YES -> stopwatch
	//  stopwatchMode == NO -> countdown
	stopwatchMode = YES;
	stopwatch = [[Timer alloc] init];
	
	//	update menubar display with time
	[self updateStatusBar];
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
	stopwatchMode = YES;
	[self updateStatusBar];
}

- (IBAction)countdownMenuClicked:(id)sender {
	// for testing only
	[stopwatch setCountdownDuration:1800];
	
	[stopwatchMenuItem setState:NSOffState];
	[countdownMenuItem setState:NSOnState];
	stopwatchMode = NO;
	[self updateStatusBar];
}

@end
