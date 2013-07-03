//
//  NSWindow+canBecomeKeyWindow.m
//  Tiny Timer
//
//  Created by River Jiang on 2013-07-03.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

#import "NSWindow+canBecomeKeyWindow.h"

@implementation NSWindow (canBecomeKeyWindow)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (BOOL) canBecomeKeyWindow {
	return YES;
}
#pragma clang diagnostic pop

@end
