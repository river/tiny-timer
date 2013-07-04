//
//  AppDelegate.h
//  Tiny Timer
//
//  Created by River Jiang on 2013-06-30.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MenuPopoverViewController.h"
#import "NSWindow+canBecomeKeyWindow.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (void) setStatusBarTitle: (NSString*)title;

@end
