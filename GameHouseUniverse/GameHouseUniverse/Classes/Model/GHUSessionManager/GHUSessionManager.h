//
//  GHUSessionManager.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import <Foundation/Foundation.h>

@class GHUApiRequest;

@interface GHUSessionManager : NSObject{
	
    BOOL newAccount;
    BOOL newGamIds;

}

@property (nonatomic, assign) BOOL newAccount;
@property (nonatomic, assign) BOOL newGamIds;


+(GHUSessionManager*)shared;

-(void)startUp;

-(void)loginWithEmail:(NSString*)_email password:(NSString*)_password  delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void)logoutWithDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void)signUpWithEmail:(NSString*)_username email:(NSString*)_email password:(NSString*)_password image:(NSString*) _image delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;

-(void)sessionChangeWithSyncKey:(NSString*)_syncKey delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void)sessionChangeBackDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void)sessionInfoDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void)syncKeySetEnabled:(BOOL)_enabled delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void)syncKeyResetWithDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void)widgetReadWithDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;

-(void)setSessionKey:(NSString*)_sessionKey;
-(NSString*)sessionKey;

-(void)enableOfflineMode:(BOOL)_enable;
-(BOOL)offlineMode;

-(BOOL)checkResponse:(GHUApiRequest*)request;
-(BOOL)checkResponse:(GHUApiRequest*)request breakOnNetworkError:(NSString*)_stringOrNil;
-(BOOL)checkResponseForPermissionAndSubscription:(GHUApiRequest*)request;
-(void)triggerLogout;
-(void)resetDataNotificationReceived;@end










































