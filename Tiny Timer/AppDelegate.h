//
//  AppDelegate.h
//  Tiny Timer
//
//  Created by River Jiang on 2013-06-30.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) IBOutlet NSStatusItem *statusBar;
@property (weak) IBOutlet NSMenu *statusMenu;

@end
