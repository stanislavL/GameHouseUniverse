//
//  GHUTable.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUTable.h"
#import "NSDictionary+ALExtended.h"

@implementation GHUTable

@synthesize table_id, name;

//===============================================================================================================
#pragma mark -
#pragma mark - dealloc Method
//===============================================================================================================
-(void) dealloc{
	
	self.table_id = nil;
	self.name = nil;
	
	[super dealloc];
}

//===============================================================================================================
#pragma mark -
#pragma mark - Read From Dictionary
//===============================================================================================================

-(void) readDataFromDictionary:(NSDictionary *)data{

    self.table_id = [NSNumber numberWithInt:[[data stringForKey:@"table_id"] intValue]];
	self.name = [data stringForKey:@"name"];
	
}


@end
