//
//  NSString+ALExtended.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "NSString+ALExtended.h"

@implementation NSString (ALExtended)

+(NSString*)getStringFromDate:(NSDate *)_date{
	return [NSString getStringFromDate:_date withFormat:@"yyyy.MM.dd HH:mm:ss"];
}

+(NSString*)getStringFromDate:(NSDate *)_date withFormat:(NSString *)_format{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:_format];
	return [dateFormatter stringFromDate:_date];
}

+(NSDate*)getDateFromString:(NSString*)_string{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	return [dateFormatter dateFromString:_string];
}

+(NSNumber*)getNumberFromString:(NSString *)_string{
	NSNumberFormatter* formatter = [[[NSNumberFormatter alloc] init] autorelease];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	return [formatter numberFromString:_string];
}

+(NSString*)getRandomStringWithLength:(int)len{
	
	NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
		
	for (int i=0; i<len; i++) {
		[randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
	}
		
	return randomString;
}

-(NSString*)withPlaceholder:(NSString *)_placeholder{
	if([self length] == 0 || [self isEqualToString:@""] || !self)
		return _placeholder;
	else 
		return self;
}

-(NSString *)stringByReplacingStringsFromDictionary:(NSDictionary *)dict{
 
	NSMutableString *string = [self mutableCopy];
    
	for (NSString *target in dict) {
		[string replaceOccurrencesOfString:target withString:[dict objectForKey:target]
								   options:0 range:NSMakeRange(0, [string length])];
    }
	
    return [string autorelease];
}

@end
