//
//  AppDelegate.m
//  Tiny Timer
//
//  Created by River Jiang on 2013-06-30.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize statusBar = _statusBar;

- (void) awakeFromNib {
	self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	
	self.statusBar.title = @"00:00";
	self.statusBar.menu = self.statusMenu;
	self.statusBar.highlightMode = YES;
	
	stopwatch = [[Timer alloc] init];
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
	
	self.statusBar.title = [stopwatch formatTimeElapsed:[stopwatch secondsElapsed]];
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
