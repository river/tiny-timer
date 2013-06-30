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
@synthesize statusBar = _statusBar;

- (void) awakeFromNib {
	self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	
	self.statusBar.menu = self.statusMenu;
	self.statusBar.highlightMode = YES;
	
	stopwatch = [[Timer alloc] init];
	[stopwatch setCountdownDuration:20];
	
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
	
	self.statusBar.title = [stopwatch formatTime:[stopwatch countdownSecondsRemaining]];
}

- (IBAction)stopwatchStartPause:(id)sender {
	if (!stopwatchTimer) {
        // start timer
        [stopwatch startTimer];
        stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateStatusBar) userInfo:nil repeats:YES];
    } else {
        // pause timer
        [stopwatch pauseTimer];
		[self updateStatusBar];
        [stopwatchTimer invalidate];
        stopwatchTimer = nil;
    }
}

- (IBAction)stopwatchReset:(id)sender {
	[stopwatch resetTimer];
    
    if (stopwatchTimer) {
        [stopwatchTimer invalidate];
        stopwatchTimer = nil;
    }
    
    [self updateStatusBar];
}
@end
