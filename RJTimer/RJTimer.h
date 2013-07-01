//
//  RJTimer.h
//
//  Created by River Jiang on 12-08-01.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJTimer : NSObject

//  Duration (seconds) from which to count down
@property (readwrite) NSTimeInterval countdownDuration;

//  Control the stopwatch/countdown
- (void) startTimer;
- (void) pauseTimer;
- (void) resetTimer;

//  Whether a stopwatch/countdown is running
- (bool) running;

//  Stopwatch/countdown current state
//  secondsElapsed: is the main method; make sure to only call this one per interface loop, to avoid wasting resources
//  countdownSecondsRemaining: is the countdown equivalent for secondsElapsed:
- (NSTimeInterval) lapSecondsElapsed;
- (NSTimeInterval) secondsElapsed;
- (NSTimeInterval) countdownSecondsRemaining;

//  Helper method to format seconds (NSTimeInterval) into pretty "00:00" or "00:00:00" strings
- (NSString*) formatTime: (NSTimeInterval)seconds;

@end
