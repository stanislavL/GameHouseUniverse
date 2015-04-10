//
//  UIButton+ALExtended.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "UIButton+ALExtended.h"

@implementation UIButton (ALExtended)

-(void)setAutosizeImage:(UIImage *)image forState:(UIControlState)state{
	[self setImage:image forState:state];
	self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
}

@end
