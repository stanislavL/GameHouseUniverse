//
//  NSDate+ALExtended.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "NSDate+ALExtended.h"

@implementation NSDate (ALExtended)

static NSDateFormatter* _dateFormatter = nil;
static NSCalendar* _calendar = nil;

- (void)dealloc{
	_dateFormatter = nil;
	_calendar = nil;
	[super dealloc];
}

+ (NSDateFormatter*)dateFormatter{
	
	if(!_dateFormatter){
		_dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		//_dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
		_dateFormatter.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];
		_dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	}
	
	return _dateFormatter;
}

+ (NSCalendar*)baseCalendar{
	
	if(!_calendar){
		_calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] autorelease];
		//_calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	}
	
	return _calendar;
}

+ (NSString *)getDate:(NSDate *)date withFormat:(NSString *)format {
    if (!date || !format) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

- (NSDate*)addDays:(int)_days{
	NSDateComponents *dayComponent = [[[NSDateComponents alloc] init] autorelease];
	dayComponent.day = _days;
	
	NSCalendar* calendar = [NSDate baseCalendar];
	return [calendar dateByAddingComponents:dayComponent toDate:self options:0];
}

- (int)daysTo:(NSDate *)_date {
	NSCalendar* calendar = [NSDate baseCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self toDate:_date options:0];
    return (int)[components day];
}

- (NSDate*)simplifyToDate{
	NSCalendar* calendar = [NSDate baseCalendar];
	return [calendar dateFromComponents:[calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:self]];
}

- (NSDate*)simplifyToTime{
	NSCalendar* calendar = [NSDate baseCalendar];
	return [calendar dateFromComponents:[calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self]];
}

- (NSDate*)simplifyToHours{
	NSCalendar* calendar = [NSDate baseCalendar];
    return [calendar dateFromComponents:[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour) fromDate:self]];
}

- (int)getHours{
	
	NSCalendar* calendar = [NSDate baseCalendar];
	NSDateComponents* _timeComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self];
	
	return (int)[_timeComponents hour];
}

- (int)getMinutes{
	
	NSCalendar* calendar = [NSDate baseCalendar];
	NSDateComponents* _timeComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self];
	
	return (int)[_timeComponents minute];
}

+ (NSDate*)combineFromDate:(NSDate *)_date time:(NSDate *)_time{
	NSCalendar* calendar = [NSDate baseCalendar];
	
	NSDateComponents* _dateComponents = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:_date];
	NSDateComponents* _timeComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:_time];
	
	NSDateComponents* _targetComponents = [[[NSDateComponents alloc] init] autorelease];
	
	[_targetComponents setDay:[_dateComponents day]];
	[_targetComponents setMonth:[_dateComponents month]];
	[_targetComponents setYear:[_dateComponents year]];
	
	[_targetComponents setHour:[_timeComponents hour]];
	[_targetComponents setMinute:[_timeComponents minute]];
	[_targetComponents setSecond:[_timeComponents second]];
	
	return [calendar dateFromComponents:_targetComponents];
}

+ (NSDate*)dateFromString:(NSString *)_string{
    return [[self dateFormatter] dateFromString:_string];
}

+ (NSDate*)dateFromString:(NSString*)_date withFormat:(NSString*)_format{
	
	NSDateFormatter* _dateFormatter = [[[NSDateFormatter alloc] init] autorelease];

    _dateFormatter.dateFormat = _format;
	//_dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	_dateFormatter.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];

    return [_dateFormatter dateFromString:_date];
}


- (NSString*)getString{
	return [self getStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString*)getStringWithFormat:(NSString *)_format{
    
    
    
	NSDateFormatter* _dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	
    _dateFormatter.dateFormat = _format;
	//_dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	_dateFormatter.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];
	
    return [_dateFormatter stringFromDate:self];
}

- (NSString*)getStringWithBuiltinFormatForTime:(NSDateFormatterStyle)_timeFormat andDate:(NSDateFormatterStyle)_dateFormat{

	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateStyle:_dateFormat];
	[dateFormatter setTimeStyle:_timeFormat];
	
    return [dateFormatter stringFromDate:self];
}

@end