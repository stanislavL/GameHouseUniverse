//
//  GHUToolbar.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUToolbar.h"

@implementation GHUToolbar

@synthesize red;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
    // Drawing code
	UIImage *image = [UIImage imageNamed:(self.red ? @"navbar_background.png" : @"picker_navbar_background.png")];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}


@end
