//
//  MenuPopoverViewController.h
//  Tiny Timer
//
//  Created by River Jiang on 2013-06-30.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AXStatusItemPopup.h"

@interface MenuPopoverViewController : NSViewController

@property(weak, nonatomic) AXStatusItemPopup *statusItemPopup;
- (IBAction)startPauseButtonPressed:(id)sender;

@end
