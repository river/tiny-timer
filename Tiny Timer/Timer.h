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
}

- (void) startTimer;
- (void) pauseTimer;
- (void) resetTimer;
- (NSTimeInterval) lapSecondsElapsed;
- (NSTimeInterval) secondsElapsed;
- (NSString*) formatTimeElapsed: (NSTimeInterval)secondsElapsed;

@end
