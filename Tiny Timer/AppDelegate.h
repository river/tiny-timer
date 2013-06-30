//
//  AppDelegate.h
//  Tiny Timer
//
//  Created by River Jiang on 2013-06-30.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Timer.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
	NSTimer *stopwatchTimer;
	Timer *stopwatch;
	bool stopwatchMode;
}

- (void) updateStatusBar;

@property (strong, nonatomic) IBOutlet NSStatusItem *statusBar;
@property (weak) IBOutlet NSMenu *statusMenu;
- (IBAction)stopwatchStartPause:(id)sender;
- (IBAction)stopwatchReset:(id)sender;
@property (weak) IBOutlet NSMenuItem *startPauseMenuItem;

@property (weak) IBOutlet NSMenuItem *stopwatchMenuItem;
- (IBAction)stopwatchMenuClicked:(id)sender;
@property (weak) IBOutlet NSMenuItem *countdownMenuItem;
- (IBAction)countdownMenuClicked:(id)sender;

@end
