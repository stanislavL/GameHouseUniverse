//
//  GHULocking.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//
#import <Foundation/Foundation.h>

@interface GHULocking : NSObject{
	NSDate* date;
	BOOL shift1;
	BOOL shift2;
	BOOL shift3;
}

@property (nonatomic, retain) NSDate* date;
@property (nonatomic, assign) BOOL shift1;
@property (nonatomic, assign) BOOL shift2;
@property (nonatomic, assign) BOOL shift3;

-(void)readDataFromDictionary:(NSDictionary*)data;
-(void)initWithDate:(NSDate*)_date;
-(NSString*)keyName;
+(NSString*)keyNameForDate:(NSDate*)_date;
-(NSArray*)arrayFromShifts;
-(NSString*)stringFromShifts;

-(int)shiftForTime:(NSDate*)_time;
-(BOOL)stateForTime:(NSDate*)_time;
-(BOOL)stateForShift:(int)_shift;
-(void)setState:(BOOL)_state ForTime:(NSDate*)_time;

@end
