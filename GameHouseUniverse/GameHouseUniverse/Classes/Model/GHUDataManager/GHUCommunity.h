//
//  GHUCommunity.h
//  GameHouseUniverse
//
//  Created by stanislav on 15/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHUCommunity : NSObject{
    
    NSNumber* community_id;
    NSString* name;
    NSString* description;
    NSNumber* members;
    NSNumber* subscribers;
    
    
}

@property (nonatomic, retain) NSNumber* community_id;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSNumber* members;
@property (nonatomic, retain) NSNumber* subscribers;

-(void)readDataFromDictionary:(NSDictionary *)data;

@end
