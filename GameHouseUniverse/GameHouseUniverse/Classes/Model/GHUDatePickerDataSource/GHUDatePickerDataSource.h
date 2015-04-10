//
//  GHUDatePickerDataSource.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <Foundation/Foundation.h>

@interface GHUDatePickerDataSource : NSObject{

	NSDate* referenceDate;
	UIPickerView* picker;
}

@property (nonatomic, retain) NSDate* referenceDate;
@property (nonatomic, retain) UIPickerView* picker;

+(GHUDatePickerDataSource*)shared;

-(int) rowForDate:(NSDate*)_date;

-(NSDate*)dateForRow:(int)_row;

-(int)rowForTime:(NSDate*)_time;
-(NSDate*)timeForRow:(int)_row;

-(int)rowsForDate;
-(int)rowsForTime;

@end
