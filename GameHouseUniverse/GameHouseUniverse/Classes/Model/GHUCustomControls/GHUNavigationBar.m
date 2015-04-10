//
//  GHUNavigationBar.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUNavigationBar.h"

@implementation GHUNavigationBar

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self initALElements];
    }
    return self;
}

- (void)awakeFromNib{
	[self initALElements];
}

-(void)initALElements{
	self.tintColor = [UIColor whiteColor];
}

-(void)middleButtonTap:(id)sender{
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
    // Drawing code
	UIImage *image = [UIImage imageNamed:@"navbar_background.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
