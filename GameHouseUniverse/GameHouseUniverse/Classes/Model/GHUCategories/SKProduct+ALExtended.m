//
//  SKProduct+ALExtended.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "SKProduct+ALExtended.h"

@implementation SKProduct (ALExtended)

-(NSString*)localizedPrice{

	NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setLocale:self.priceLocale];
	
	return [numberFormatter stringFromNumber:self.price];
}

@end
