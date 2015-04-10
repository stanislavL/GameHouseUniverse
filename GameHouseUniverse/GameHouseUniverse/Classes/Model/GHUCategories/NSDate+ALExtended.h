//
//  NSDate+ALExtended.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

@interface NSDate (ALExtended)

+ (NSString*)getDate:(NSDate *)date withFormat:(NSString *)format;

+ (NSDateFormatter*)dateFormatter;
+ (NSCalendar*)baseCalendar;

// New
- (NSDate*)addDays:(int)_days;
- (int)daysTo:(NSDate *)_date;

- (NSDate*)simplifyToDate;
- (NSDate*)simplifyToTime;
- (NSDate*)simplifyToHours;

- (NSString*)getString;
- (NSString*)getStringWithFormat:(NSString*)_format;
- (NSString*)getStringWithBuiltinFormatForTime:(NSDateFormatterStyle)_timeFormat andDate:(NSDateFormatterStyle)_dateFormat;

- (int)getHours;
- (int)getMinutes;

+ (NSDate*)dateFromString:(NSString*)_string;
+ (NSDate*)dateFromString:(NSString*)_string withFormat:(NSString*)_format;
+ (NSDate*)combineFromDate:(NSDate*)_date time:(NSDate*)_time;

@end
