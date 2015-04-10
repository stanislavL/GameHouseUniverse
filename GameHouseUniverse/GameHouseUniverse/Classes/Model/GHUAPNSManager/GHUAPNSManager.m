//
//  GHUAPNSManager.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUAPNSManager.h"
#import "GHUSettingsManager.h"
#import "GHUSessionManager.h"
#import "GHUSettingsManager.h"
#import "GHUApiRequest.h"
#import "GHUDefaultsManager.h"
#import "GHUAlertView.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation GHUAPNSManager
static GHUAPNSManager* _sharedManager = nil;
@synthesize defaults;

//========================================================================================================================================================
#pragma mark -
#pragma mark Methods of dealloc
//========================================================================================================================================================
- (void)dealloc{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	self.defaults = nil;
	[super dealloc];
}

+ (GHUAPNSManager*)shared {
	
	@synchronized(self){
		if(_sharedManager == NULL){
			_sharedManager = [[self alloc] init];
		}
	}
	
	return(_sharedManager);
}

- (id) init{
	
    self = [super init];
	
	if(self){
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLoginNotification:) name:@"loggedIn" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSessionChangedNotification:) name:@"sessionChanged" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLogoutNotification:) name:@"loggedOut" object:nil];
	}
	
	return self;
}

- (void) registerForRemoteNotifications{

	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

- (void) receiveDeviceTokenSuccessForApp:(UIApplication *)_app deviceToken:(NSData *)_deviceToken{
	
	NSString* token=[NSString stringWithFormat:@"%@", _deviceToken];
	token =[token substringWithRange:NSMakeRange(1, [token length]-2)];
	token =[token stringByReplacingOccurrencesOfString:@" " withString:@""];
	[[GHUDefaultsManager shared] setDeviceToken:token];
	
	[[GHUDefaultsManager shared] setApnsEnabled:YES];
	[[GHUDefaultsManager shared] setApnsSent:NO];
	[[GHUDefaultsManager shared] setApnsPending:YES];
	[self initiateSendingOfPendingDeviceToken];
}

- (void) receiveDeviceTokenFailureForApp:(UIApplication *)_app error:(NSError *)_error{
	
    [[GHUDefaultsManager shared] setApnsEnabled:NO];
}

- (void) initiateSendingOfPendingDeviceToken{

	if([[GHUDefaultsManager shared] apnsSent] == NO && [[GHUDefaultsManager shared] apnsPending] == YES && [[GHUDefaultsManager shared] deviceToken] && [[GHUSessionManager shared] sessionKey])
		[self sendDeviceToken];
		
}

- (void) sendDeviceToken{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:[[GHUDefaultsManager shared] deviceToken] forKey:@"device_token"];
	[parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
	[parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"apns_register" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
			
            [[GHUDefaultsManager shared] setApnsSent:YES];
			[[GHUDefaultsManager shared] setApnsPending:NO];
		}
		else{
			
            [[GHUDefaultsManager shared] setApnsSent:NO];
			[[GHUDefaultsManager shared] setApnsPending:YES];
		}
	}];
}

- (BOOL) remoteNotificationsEnabled{
	
    return [[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone ? NO : YES;
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - Notifications Delegate
//======================================================================================================================================================================
- (void) didReceiveLoginNotification:(NSNotification *)_notification{
	
    [[GHUDefaultsManager shared] setApnsPending:YES];
	[self registerForRemoteNotifications];
}

- (void) didReceiveSessionChangedNotification:(NSNotification *)_notification{

	[[GHUDefaultsManager shared] setApnsPending:YES];
	[self registerForRemoteNotifications];
}

- (void) didReceiveLogoutNotification:(NSNotification *)_notification{
	
    [[GHUDefaultsManager shared] setApnsSent:NO];
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - Handle remote notifications
//======================================================================================================================================================================
- (void) didReceiveRemoteNotification:(NSDictionary *)_notification{

	if([_notification objectForKey:@"t"]){
		if([[_notification objectForKey:@"t"] isEqualToString:@"new_request"]){
			[[NSNotificationCenter defaultCenter] postNotificationName:@"requestNotificationReceived" object:self];
		}
	}
}

@end
