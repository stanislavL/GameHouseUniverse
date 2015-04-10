//
//  GHUUserInfo.h
//  GameHouseUniverse
//
//  Created by stanislav on 17/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHUGameIDs.h"
#import "GHUCommunity.h"

@interface GHUUserInfo : NSObject{
    
    NSString* username;
    NSString* email;
    NSString* pwd;
    NSString* memberDate;
    UIImage* imageData;


}
@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* pwd;
@property (nonatomic, retain) NSString* memberDate;
@property (nonatomic, retain) UIImage* imageData;

-(void)readDataFromDictionary:(NSDictionary*)data;
- (UIImage*) doImageMask:(UIImage *)mainImage withMask:(UIImage *)maskImage;
@end
