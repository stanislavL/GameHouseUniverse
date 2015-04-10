//
//  GHUBarButtonItem.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUBarButtonItem.h"

@implementation GHUBarButtonItem

-(id)initWithImageNamed:(NSString *)_imageName imageHighlightedNamed:(NSString *)_imageHighlightedName title:(NSString *)_title target:(id)_target selector:(SEL)_selector {
	 
	UIImage* image = [UIImage imageNamed:_imageName];
	UIImage* imageHighlighted = [UIImage imageNamed:_imageHighlightedName];
	
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];

	[button setBackgroundImage:image forState:UIControlStateNormal];
	[button setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];

	[button setTitle:_title forState:UIControlStateNormal];
	[button setTitle:_title forState:UIControlStateHighlighted];
	
	button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	
	[button addTarget:_target action:_selector forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *barButton = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
	
	return (GHUBarButtonItem*)barButton;
}

-(id)initWithImageNamed:(NSString *)_imageName imageHighlightedNamed:(NSString *)_imageHighlightedName target:(id)_target selector:(SEL)_selector	{
	
	return [self initWithImageNamed:_imageName imageHighlightedNamed:_imageHighlightedName title:@"" target:_target selector:_selector];
}

@end
