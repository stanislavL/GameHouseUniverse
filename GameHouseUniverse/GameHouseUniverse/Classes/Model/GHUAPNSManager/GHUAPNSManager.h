//
//  GHUAPNSManager.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <Foundation/Foundation.h>
#import "GHUApiRequest.h"

@interface GHUAPNSManager : NSObject{

	NSUserDefaults* defaults;
}

@property (nonatomic, retain) NSUserDefaults* defaults;


+ (GHUAPNSManager*)shared;

- (void)registerForRemoteNotifications;
- (void)initiateSendingOfPendingDeviceToken;
- (BOOL)remoteNotificationsEnabled;

- (void)sendDeviceToken;

- (void)receiveDeviceTokenSuccessForApp:(UIApplication*)_app deviceToken:(NSData*)_deviceToken;
- (void)receiveDeviceTokenFailureForApp:(UIApplication*)_app error:(NSError*)_error;

- (void)didReceiveLoginNotification:(NSNotification*)_notification;
- (void)didReceiveLogoutNotification:(NSNotification*)_notification;

- (void)didReceiveRemoteNotification:(NSDictionary*)_notification;

@end
