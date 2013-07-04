//
//  AppDelegate.m
//  Tiny Timer
//
//  Created by River Jiang on 2013-06-30.
//  Copyright (c) 2013 River Jiang. All rights reserved.
//

//  TODO prettier interface, instead of using default menu dropdown
//  TODO nicer indication of whether the timer/countdown is running than using the play/pause unicode characters (which are way too bold for the job) -- is it possible to have images alongside the text label?

#import "AppDelegate.h"

@interface AppDelegate() {
	AXStatusItemPopup *_statusItemPopup;
}

@end

@implementation AppDelegate

- (void) awakeFromNib {
	
	// init MenuPopoverViewController (shown inside the popover)
	MenuPopoverViewController *menuPopoverViewController = [[MenuPopoverViewController alloc] initWithNibName:@"MenuPopoverViewController" bundle:nil];

	// init AXStatusItemPopup
	NSImage *image = [NSImage imageNamed:@"cloud"];
	NSImage *altImage = [NSImage imageNamed:@"cloudgrey"];
	_statusItemPopup = [[AXStatusItemPopup alloc] initWithViewController:menuPopoverViewController image:image alternateImage:altImage label:@"00:00"];
	_statusItemPopup.animated = NO;
	menuPopoverViewController.statusItemPopup = _statusItemPopup;
	
}

- (void) setStatusBarTitle: (NSString*)title {
	[_statusItemPopup setStatusBarTitle:title];
}

@end
