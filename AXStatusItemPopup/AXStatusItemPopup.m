//
//  StatusItemPopup.m
//  StatusItemPopup
//
//  Created by Alexander Schuch on 06/03/13.
//  Copyright (c) 2013 Alexander Schuch. All rights reserved.
//

#import "AXStatusItemPopup.h"

//
// Private variables
//
@interface AXStatusItemPopup () {
    NSViewController *_viewController;
    BOOL _active;
    NSImageView *_imageView;
	NSTextField *_textField;
    NSStatusItem *_statusItem;
    NSPopover *_popover;
	CGFloat height;
}
@end

///////////////////////////////////

//
// Implementation
//
@implementation AXStatusItemPopup

- (id)initWithViewController:(NSViewController *)controller
{
    return [self initWithViewController:controller image:nil];
}

- (id)initWithViewController:(NSViewController *)controller image:(NSImage *)image
{
    return [self initWithViewController:controller image:image alternateImage:nil];
}

//  TODO init with label
- (id)initWithViewController:(NSViewController *)controller image:(NSImage *)image alternateImage:(NSImage *)alternateImage
{
    height = [NSStatusBar systemStatusBar].thickness;
    
    self = [super initWithFrame:NSMakeRect(0, 0, 0, 0)];
    if (self) {
        _viewController = controller;
        
        self.image = image;
        self.alternateImage = alternateImage;
        
        _imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 22, height)];
        [self addSubview:_imageView];
		
		_textField = [[NSTextField alloc] initWithFrame:NSMakeRect(22, 3, 0, height)];
		[_textField setFont:[NSFont menuBarFontOfSize:0]];
		[_textField setBordered:NO];
		[_textField setDrawsBackground:NO];
        [_textField setStringValue:@"00:00:00"];
		[_textField setSelectable:NO];
		[self addSubview:_textField];
		
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        _statusItem.view = self;
        
        _active = NO;
        _animated = YES;
    }
	[self updateViewFrame];
    return self;
}

- (void) setStatusBarTitle: (NSString *)title {
	[_textField setStringValue:title];
	[self updateViewFrame];
}


////////////////////////////////////
#pragma mark - Drawing
////////////////////////////////////

- (void)drawRect:(NSRect)dirtyRect
{
    // set view background color
    if (_active) {
        [[NSColor selectedMenuItemColor] setFill];
    } else {
        [[NSColor clearColor] setFill];
    }
    NSRectFill(dirtyRect);
    
    // set image
    NSImage *image = (_active ? _alternateImage : _image);
    _imageView.image = image;
}

////////////////////////////////////
#pragma mark - Mouse Actions
////////////////////////////////////

- (void)mouseDown:(NSEvent *)theEvent
{
    if (_popover.isShown) {
        [self hidePopover];
    } else {
        [self showPopover];
    }    
}

////////////////////////////////////
#pragma mark - Setter
////////////////////////////////////

- (void)setActive:(BOOL)active
{
    _active = active;
    [self setNeedsDisplay:YES];
}

- (void)setImage:(NSImage *)image
{
    _image = image;
    [self updateViewFrame];
}

- (void)setAlternateImage:(NSImage *)image
{
    _alternateImage = image;
    if (!image && _image) {
        _alternateImage = _image;
    }
    [self updateViewFrame];
}

////////////////////////////////////
#pragma mark - Helper
////////////////////////////////////

- (void)updateViewFrame
{
	[_textField sizeToFit];
    CGFloat width = MAX(self.alternateImage.size.width, self.image.size.width) + [_textField frame].size.width + 8;
	
    NSRect frame = NSMakeRect(0, 0, width, height);
    self.frame = frame;
    
    [self setNeedsDisplay:YES];
}


////////////////////////////////////
#pragma mark - Show / Hide Popover
////////////////////////////////////

- (void)showPopover
{
    [self showPopoverAnimated:_animated];
}

- (void)showPopoverAnimated:(BOOL)animated
{
    self.active = YES;
    
    if (!_popover) {
        _popover = [[NSPopover alloc] init];
        _popover.contentViewController = _viewController;
    }
    
    if (!_popover.isShown) {
        _popover.animates = animated;
        [_popover showRelativeToRect:self.frame ofView:self preferredEdge:NSMinYEdge];
    }
}

- (void)hidePopover
{
    self.active = NO;
    
    if (_popover && _popover.isShown) {
        [_popover close];
    }
}

@end

