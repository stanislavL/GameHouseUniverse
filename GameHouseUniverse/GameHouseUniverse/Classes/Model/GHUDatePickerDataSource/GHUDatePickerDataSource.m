//
//  GHUDatePickerDataSource.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUDatePickerDataSource.h"
#import "NSDate+ALExtended.h"

@implementation GHUDatePickerDataSource

static GHUDatePickerDataSource* _sharedManager = nil;

@synthesize referenceDate;
@synthesize picker;

-(void)dealloc{
	self.referenceDate = nil;
	[super dealloc];
}

-(id)init{
	self = [super init];
    if (self) {
		self.referenceDate = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    }
    return self;
}

+(GHUDatePickerDataSource*)shared {
	
	@synchronized(self){
		if(_sharedManager == NULL){
			_sharedManager = [[self alloc] init];
		}
	}
	
	return(_sharedManager);
}

-(int)rowForDate:(NSDate*)_date{
	return [self.referenceDate daysTo:_date];
}

-(NSDate*)dateForRow:(int)_row{
	return [self.referenceDate addDays:_row];
}

-(int)rowForTime:(NSDate*)_time{

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	//calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSDateComponents* _timeComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:_time];
	
	int _quarter;
	
	if([_timeComponents minute] < 15)
		_quarter = 0;
	else if([_timeComponents minute] < 30)
		_quarter = 1;
	else if([_timeComponents minute] < 45)
		_quarter = 2;
	else
		_quarter = 3;
	
	return ([self.referenceDate daysTo:_time]*24*4) + [_timeComponents hour]*4 + _quarter;
}

-(NSDate*)timeForRow:(int)_row{
	
	NSCalendar* calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] autorelease];

	NSDateComponents* _dateComponents = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[self.referenceDate addDays:_row/96]];

	NSDateComponents *_timeComponents = [[[NSDateComponents alloc] init] autorelease];
	_timeComponents.hour = ((_row%96)/4);
	_timeComponents.minute = (((_row%96)%4)*15);
	
	_timeComponents.day = _dateComponents.day;
	_timeComponents.month = _dateComponents.month;
	_timeComponents.year = _dateComponents.year;
	
	return [calendar dateFromComponents:_timeComponents];
}

-(int)rowsForDate{
	return 365*80;
}

-(int)rowsForTime{
	return 24*4*365*80;
}

@end
