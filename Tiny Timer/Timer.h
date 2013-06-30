//
//  Timer.h
//  Reading Speed
//
//  Created by River Jiang on 12-08-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject {
    NSDate* startDate;
    NSTimeInterval timeInterval;
    NSTimeInterval lapTimeInterval;
    BOOL stopwatchRunning;
	
	//  countdown
	NSTimeInterval countdownDuration;
}

@property (readwrite) NSTimeInterval countdownDuration;

- (void) startTimer;
- (void) pauseTimer;
- (void) resetTimer;
- (bool) running;
- (NSTimeInterval) lapSecondsElapsed;
- (NSTimeInterval) secondsElapsed;
- (NSTimeInterval) countdownSecondsRemaining;
- (NSString*) formatTime: (NSTimeInterval)seconds;

@end
