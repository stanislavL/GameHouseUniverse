//
//  GHUDefaultsManager.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <Foundation/Foundation.h>
#import "GHUUserInfo.h"
#import "GHUGameIDs.h"

@interface GHUDefaultsManager : NSObject{
	
    NSUserDefaults* defaults;
}

+(GHUDefaultsManager*)shared;

-(void)setSessionKey:(NSString*)_sessionKey;
-(NSString*)sessionKey;

-(void)setLoggedIn:(BOOL)_loggedIn;
-(BOOL)loggedIn;

- (void) setUserInfo:(GHUUserInfo*) info;
- (GHUUserInfo*) getUserInfo;

-(void) setProfileImage:(UIImage*) image;
-(UIImage*) getProfileImage;

-(void) setProfileData:(NSMutableArray*) data;
-(NSMutableArray*) ProfileData;

-(void)setApnsEnabled:(BOOL)_apnsEnabled;
-(BOOL)apnsEnabled;

-(void)setApnsPending:(BOOL)_apnsPending;
-(BOOL)apnsPending;

-(void)setApnsSent:(BOOL)_apnsSent;
-(BOOL)apnsSent;

-(void)setDeviceToken:(NSString*)_deviceToken;
-(NSString*)deviceToken;

-(void)setColumnStoreInitialized:(BOOL)_initialized;
-(BOOL)columnStoreInitialized;

-(void)columnStoreSetColumnId:(NSString*)_columnId forKey:(NSString*)_key;
-(NSString*)columnStoreColumnIdForKey:(NSString*)_key;

-(NSString*)textTemplateRequestAccept;
-(void)setTextTemplateRequestAccept:(NSString*)_text;

-(NSString*)textTemplateRequestReject;
-(void)setTextTemplateRequestReject:(NSString*)_text;

-(NSString*)customLine;
-(void)setCustomLine:(NSString*)_text;

-(BOOL)introSeen;
-(void)setIntroSeen:(BOOL)_seen;


@property (nonatomic, retain) NSUserDefaults* defaults;


@end
