//
//  GHULocking.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHULocking.h"
#import "NSDictionary+ALExtended.h"
#import "NSDate+ALExtended.h"

@implementation GHULocking

@synthesize date;
@synthesize shift1, shift2, shift3;

-(void)dealloc{
	self.date = nil;
	[super dealloc];
}

-(void)readDataFromDictionary:(NSDictionary *)data{
	
	if(![data isNullForKey:@"date"])
		self.date = [[NSDate dateFromString:[data stringForKey:@"date"] withFormat:@"yyyyMMdd"] simplifyToDate];
		
	if(![data isNullForKey:@"shifts"]){
		
		int amount = [[data arrayForKey:@"shifts"] count];
		
		if(amount >= 1)
			self.shift1 = [[[data arrayForKey:@"shifts"] objectAtIndex:0] isEqualToString:@"1"];
		
		if(amount >= 2)
			self.shift2 = [[[data arrayForKey:@"shifts"] objectAtIndex:1] isEqualToString:@"1"];
			
		if(amount >= 3)
			self.shift3 = [[[data arrayForKey:@"shifts"] objectAtIndex:2] isEqualToString:@"1"];
	}
}

-(void)initWithDate:(NSDate*)_date{
	self.date = [_date simplifyToDate];
}

-(NSString*)keyName{
	return [GHULocking keyNameForDate:self.date];
}

+(NSString*)keyNameForDate:(NSDate*)_date{
	return [_date getStringWithFormat:@"yyyyMMdd"];
}

-(NSArray*)arrayFromShifts{
	return [NSArray arrayWithObjects:self.shift1 ? @"1" : @"0", self.shift2 ? @"1" : @"0", self.shift3 ? @"1" : @"0", nil];
}

-(NSString*)stringFromShifts{
	return [NSString stringWithFormat:@"%@%@%@", self.shift1 ? @"1" : @"0", self.shift2 ? @"1" : @"0", self.shift3 ? @"1" : @"0"];
}

-(int)shiftForTime:(NSDate *)_time{
	if([_time getHours] >= 0 && [_time getHours] < 12){
		return 1;
	}
	else if([_time getHours] >= 12 && [_time getHours] < 18){
		return 2;
	}
	else{
		return 3;
	}
}

-(BOOL)stateForTime:(NSDate*)_time{
	
	int shift = [self shiftForTime:_time];
	
	if(shift == 1){
		return self.shift1;
	}
	else if(shift == 2){
		return self.shift2;
	}
	else{
		return self.shift3;
	}
}

- (BOOL)stateForShift:(int)_shift{
	
	if(_shift == 1){
		return self.shift1;
	}
	else if(_shift == 2){
		return self.shift2;
	}
	else{
		return self.shift3;
	}
}

-(void)setState:(BOOL)_state ForTime:(NSDate*)_time{
	
	int shift = [self shiftForTime:_time];
	
	if(shift == 1){
		self.shift1 = _state;
	}
	else if(shift == 2){
		self.shift2 = _state;
	}
	else{
		self.shift3 = _state;
	}
}


@end
