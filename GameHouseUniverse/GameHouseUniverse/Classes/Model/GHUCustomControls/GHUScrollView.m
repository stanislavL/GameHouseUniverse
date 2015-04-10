//
//  GHUScrollView.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUScrollView.h"

@implementation GHUScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setScrollingToFirstSubview];
    }
    return self;
}

- (void)awakeFromNib{
	[super awakeFromNib];
	[self setScrollingToFirstSubview];
}

- (void)setScrollingToFirstSubview{
	
	if(!self.subviews || [self.subviews count] == 0)
		return;
		
	if([[self.subviews objectAtIndex:0] class] != [UIView class])
		return;
		
	self.contentSize = ((UIView*)[self.subviews objectAtIndex:0]).frame.size;
}

@end
