//
//  GHUCompany.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUGame.h"
#import "NSDictionary+ALExtended.h"

@implementation GHUGame

@synthesize game_id, name;

- (void) dealloc{
	self.game_id = nil;
	self.name = nil;
	[super dealloc];
}


-(void)readDataFromDictionary:(NSDictionary *)data{
	
    self.game_id = [NSNumber numberWithInt:[[data stringForKey:@"game_id"] intValue]];
	self.name = [data stringForKey:@"name"];
	
}

@end
