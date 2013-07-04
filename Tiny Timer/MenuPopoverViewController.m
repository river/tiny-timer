//
//  MenuPopoverViewController.m
//  Tiny Timer
//
//  Created by River Jiang on 2013-06-30.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

#import "MenuPopoverViewController.h"

@interface MenuPopoverViewController () {
	NSTimer *stopwatchTimer;
	RJTimer *stopwatch;
	bool stopwatchMode;
}

@end

@implementation MenuPopoverViewController

// statusItemPopup is passed to MenuPopoverViewController by AppDelegate upon initializing the AXStatusItemPopup class
@synthesize statusItemPopup;

// synthesize UI elements
@synthesize startPauseButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		//	init stopwatch object
		//  YES -> stopwatch; NO -> countdown
		stopwatchMode = YES;
		stopwatch = [[RJTimer alloc] init];
		
		//  default countdown duration: 30 min
		[stopwatch setCountdownDuration:1800];
		
		//	update menubar display with time
		[self updateStatusBar];
    }
    
    return self;
}

- (void) updateStatusBar {
	NSString* stopwatchTime;
	if (stopwatchMode) {
		stopwatchTime = [stopwatch formatTime:[stopwatch secondsElapsed]];
	} else {
		stopwatchTime = [stopwatch formatTime:[stopwatch countdownSecondsRemaining]];
	}
	[statusItemPopup setStatusBarTitle:stopwatchTime];
}

- (void) setCountdownDuration: (NSTimeInterval *)countdownDuration {
	[stopwatch setCountdownDuration:*countdownDuration];
	[self updateStatusBar];
}

- (IBAction)stopwatchStartPause:(id)sender {
	if (!stopwatchTimer) {
		// start timer
		[stopwatch startTimer];
		stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateStatusBar) userInfo:nil repeats:YES];
		
		// change button text
		[startPauseButton setTitle:@"Pause"];
	} else {
		// pause timer
		[stopwatch pauseTimer];
		[self updateStatusBar];
		[stopwatchTimer invalidate];
		stopwatchTimer = nil;
		
		// change button text
		[startPauseButton setTitle:@"Start"];
	}
}

- (IBAction)stopwatchReset:(id)sender {
}

- (IBAction)closePopover:(id)sender {
	[statusItemPopup hidePopover];
}

@end

//- (IBAction)stopwatchStartPause:(id)sender {
//	if (!stopwatchTimer) {
//        // start timer
//        [stopwatch startTimer];
//        stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateStatusBar) userInfo:nil repeats:YES];
////		[startPauseMenuItem setTitle:@"Pause"];
//    } else {
//        // pause timer
//        [stopwatch pauseTimer];
//		[self updateStatusBar];
//        [stopwatchTimer invalidate];
//        stopwatchTimer = nil;
////		[startPauseMenuItem setTitle:@"Resume"];
//    }
//}
//
//- (IBAction)stopwatchReset:(id)sender {
//	[stopwatch resetTimer];
//
//    if (stopwatchTimer) {
//        [stopwatchTimer invalidate];
//        stopwatchTimer = nil;
//    }
//
//    [self updateStatusBar];
////	[startPauseMenuItem setTitle:@"Start"];
//}
//
//- (IBAction)stopwatchMenuClicked:(id)sender {
//	stopwatchMode = YES;
//	[self updateStatusBar];
//}
//
//- (IBAction)countdownMenuClicked:(id)sender {
//	stopwatchMode = NO;
//	[self updateStatusBar];
//}

//- (NSString *)	input: (NSString *)prompt
//				defaultValue: (NSString *)defaultValue
//				informativeText: (NSString *)informativeText {
//	NSAlert *alert = [NSAlert alertWithMessageText:prompt
//									 defaultButton:@"OK"
//								   alternateButton:@"Cancel"
//									   otherButton:nil
//						 informativeTextWithFormat:@"%@", informativeText];
//
//	NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 300, 24)];
//	[input setStringValue:defaultValue];
//	[alert setAccessoryView:input];
//	NSInteger button = [alert runModal];
//	if (button == NSAlertDefaultReturn) {
//		[input validateEditing];
//		return [input stringValue];
//	} else if (button == NSAlertAlternateReturn) {
//		return nil;
//	} else {
//		return nil;
//	}
//}
//
//- (IBAction)countdownDurationMenuClicked:(id)sender {
//	NSString *input = [self input:@"Set countdown duration (seconds)" defaultValue:[NSString stringWithFormat:@"%.f", [stopwatch countdownDuration]] informativeText:@"Don't worry, this will not reset the current countdown timer."];
//	if (input) {
//		NSTimeInterval inputInterval = [input doubleValue];
//		[self setCountdownDuration:&inputInterval];
//	}
//}
