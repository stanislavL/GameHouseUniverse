//
//  NSString+ALExtended.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import <Foundation/Foundation.h>

@interface NSString (ALExtended)

+(NSString*)getStringFromDate:(NSDate*)_date;
+(NSString*)getStringFromDate:(NSDate*)_date withFormat:(NSString*)_format;
+(NSDate*)getDateFromString:(NSString*)_string;
+(NSNumber*)getNumberFromString:(NSString*)_string;
+(NSString*)getRandomStringWithLength:(int)len;

-(NSString*)withPlaceholder:(NSString*)_placeholder;
-(NSString *)stringByReplacingStringsFromDictionary:(NSDictionary *)dict;

@end
