//
//  UINavigationItem+ALExtended.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "UINavigationItem+ALExtended.h"

@implementation UINavigationItem (ALExtended)

- (void)setLeftButton:(UIButton *)_button withPadding:(BOOL)_padding{
	
	UIBarButtonItem* bbi = [[[UIBarButtonItem alloc] initWithCustomView:_button] autorelease];
	
	UIBarButtonItem *negativeSpacer = [[[UIBarButtonItem alloc] 
										initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace 
										target:nil action:nil] autorelease];
	negativeSpacer.width = -5; 
	
    if(!_padding &&  [[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 5)
		self.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, bbi, nil];
	else 
		self.leftBarButtonItem = bbi;
}

- (void)setRightButton:(UIButton *)_button withPadding:(BOOL)_padding{
	
	UIBarButtonItem* bbi = [[[UIBarButtonItem alloc] initWithCustomView:_button] autorelease];
	
	UIBarButtonItem *negativeSpacer = [[[UIBarButtonItem alloc] 
										initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace 
										target:nil action:nil] autorelease];
	negativeSpacer.width = -5; 
	
	if(!_padding &&  [[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 5)
		self.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, bbi, nil];
	else 
		self.rightBarButtonItem = bbi;
}

@end
