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

- (void) awakeFromNib
{
	self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	
	self.statusBar.title = @"Test";
	
	self.statusBar.menu = self.statusMenu;
	self.statusBar.highlightMode = YES;
}

@end
