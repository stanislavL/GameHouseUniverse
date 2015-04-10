//
//  UIColor+ALExtended.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "UIColor+ALExtended.h"
#import "GHUSettingsManager.h"

@implementation UIColor (ALExtended)

+(UIColor*)ALBlueColor{
	return [UIColor colorWithRed:51.0/255.0 green:102.0/255.0 blue:153.0/155.0 alpha:1.0];
}

+(UIColor*)colorFromSettings:(NSString *)_identifier{
	
	NSArray* colorSegments = [[GHUSettingsManager shared] colorArray:_identifier];
	
	if(!colorSegments || [colorSegments count] != 4)
		return [UIColor blackColor];
		
	return [UIColor colorWithRed:[[colorSegments objectAtIndex:0] floatValue]/255.0 green:[[colorSegments objectAtIndex:1] floatValue]/255.0 blue:[[colorSegments objectAtIndex:2] floatValue]/255.0 alpha:[[colorSegments objectAtIndex:3] floatValue]/255.0];
}

@end
