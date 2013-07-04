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
@synthesize startPauseButton, countdownHourTextField, countdownMinuteTextField, countdownSecondTextField;

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

- (void) updateCountdownDuation {
	double newDuration = [countdownHourTextField intValue]*3600 + [countdownMinuteTextField intValue]*60 + [countdownSecondTextField intValue];
	[self setCountdownDuration:&newDuration];
}

- (IBAction)stopwatchCountdownSegmentedControl:(NSSegmentedControl*)sender {
	NSInteger cell = [sender selectedSegment];
	if (cell == 0) {
		// stopwatch clicked
		stopwatchMode = YES;
		[self updateStatusBar];
	} else if (cell == 1) {
		// countdown clicked
		stopwatchMode = NO;
		[self updateStatusBar];
	}
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
	[stopwatch resetTimer];
	
	if (stopwatchTimer) {
		[stopwatchTimer invalidate];
		stopwatchTimer = nil;
	}
	
	[self updateStatusBar];
	[startPauseButton setTitle:@"Start"];
}

- (IBAction)resetCountdown:(id)sender {
	[countdownHourTextField setStringValue:@"00"];
	[countdownMinuteTextField setStringValue:@"30"];
	[countdownSecondTextField setStringValue:@"00"];
	[self updateCountdownDuation];
}

- (IBAction)closePopover:(id)sender {
	[statusItemPopup hidePopover];
}

- (IBAction)countdownHourEdit:(id)sender {
	[self updateCountdownDuation];
}

- (IBAction)countdownMinuteEdit:(id)sender {
	[self updateCountdownDuation];
}

- (IBAction)countdownSecondEdit:(id)sender {
	[self updateCountdownDuation];
}
@end


