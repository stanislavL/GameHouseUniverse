//
//  GHUCommunity.m
//  GameHouseUniverse
//
//  Created by stanislav on 15/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "GHUCommunity.h"
#import "NSDictionary+ALExtended.h"

@implementation GHUCommunity
@synthesize community_id;
@synthesize name;
@synthesize description;
@synthesize members;
@synthesize subscribers;

- (void) dealloc{
    
    self.community_id = nil;
    self.name = nil;
    self.description = nil;
    self.members = nil;
    self.subscribers = nil;
    
    [super dealloc];
    
}
- (void)readDataFromDictionary:(NSDictionary *)data{
    
    self.community_id = [NSNumber numberWithInt:[[data stringForKey:@"community_id"] intValue]];
	self.name = [data stringForKey:@"name"];
    self.description = [data stringForKey:@"description"];
    self.members = [NSNumber numberWithInt:[[data stringForKey:@"member"] intValue]];
    self.subscribers = [NSNumber numberWithInt:[[data stringForKey:@"subscriber"] intValue]];
}


@end
