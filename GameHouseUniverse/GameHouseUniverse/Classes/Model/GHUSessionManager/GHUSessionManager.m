//
//  GHUSessionManager.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "GHUSessionManager.h"
#import "GHUApiRequest.h"
#import "GHUDataManager.h"
#import "GHUScreenManager.h"
#import "GHUAlertView.h"
#import "GHUSettingsManager.h"

@implementation GHUSessionManager

@synthesize newAccount;

static GHUSessionManager* _sharedManager = nil;

-(void)dealloc{
	
    _sharedManager = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

+(GHUSessionManager*)shared {
	
	@synchronized(self){
		if(_sharedManager == NULL){
			_sharedManager = [[self alloc] init];
		}
	}
	
	return(_sharedManager);
}

-(id)init{
	
    self = [super init];
	
	if(self){
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetDataNotificationReceived) name:@"resetData" object:nil];
	}
	return self;
}

- (void) startUp{

    // *******************Session Key Checking ****************
	if ([self sessionKey] && [[self sessionKey] length] > 0){
        //--- sessionkey exist-----
        [[GHUDataManager shared] loadFullData];
    
    } else {
        //-----create account-------
        [[GHUScreenManager shared] goToScreen:@"login"];
    }
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Login/Logout
//========================================================================================================================================================
-(void)loginWithEmail:(NSString*)_email password:(NSString*)_password delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{

	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:_email forKey:@"email"];
	[parameters setObject:_password forKey:@"password"];
	
    [parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
	[parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];

    GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"login" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
			
            self.newAccount = NO;
			
            [self setSessionKey:request.sessionID];
			[[NSNotificationCenter defaultCenter] postNotificationName:@"loggedIn" object:self];
			
			if ([_delegate respondsToSelector:_success]) {
				
                [_delegate performSelector:_success withObject:request];
			}
		}else {
			if ([_delegate respondsToSelector:_failure]) {
				
                [_delegate performSelector:_failure withObject:request];
			}
		}
	}];
}


-(void)logoutWithDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
    [parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
    [parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];

	[request triggerHandler:@"logout" withMethod:@"get" parameters:parameters callback:^{
		
		if(request.status == 100){ 
		
			// delete session_key
			[self triggerLogout];
			
			if ([_delegate respondsToSelector:_success]){
				[_delegate performSelector:_success withObject:request];
			}
		}
		else {
			if ([_delegate respondsToSelector:_failure]) {
		
                [_delegate performSelector:_failure withObject:request];
			}
		}
		
	}];
}

-(void)signUpWithEmail:(NSString*)_username email:(NSString*)_email password:(NSString*)_password image:(NSString*) _image delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
    [parameters setObject:_username forKey:@"username"];
	[parameters setObject:_email forKey:@"email"];
	[parameters setObject:_password forKey:@"password"];
    [parameters setObject:_image forKey:@"profile_image"];
   
    [parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
	[parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
	
    GHUApiRequest* request = [[GHUApiRequest alloc] init];


    [request triggerHandler:@"register" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
		
			self.newAccount = YES;
            self.newGamIds = YES;
			[self setSessionKey:request.sessionID];

			
			if ([_delegate respondsToSelector:_success]) {
				[_delegate performSelector:_success withObject:request];
			}
		}
		else {
			if ([_delegate respondsToSelector:_failure]) {
				[_delegate performSelector:_failure withObject:request];
			}
		}
	}];
}

-(void) triggerLogout{
	
	// delete session_key
	[self setSessionKey:@""];
	
	// send notification
	[[NSNotificationCenter defaultCenter] postNotificationName:@"loggedOut" object:self];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"resetData" object:self];
}

-(void)setSessionKey:(NSString *)_sessionKey{
	
    [[NSUserDefaults standardUserDefaults] setObject:_sessionKey forKey:@"session_key"];
}

-(NSString*)sessionKey{
	
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"session_key"];
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Offline mode
//========================================================================================================================================================
-(void)enableOfflineMode:(BOOL)_enable{
	
    [[NSUserDefaults standardUserDefaults] setBool:_enable forKey:@"offline_mode"];
}

-(BOOL)offlineMode{
	
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"offline_mode"];
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Notifications
//========================================================================================================================================================
-(void)resetDataNotificationReceived{
	
    self.newAccount = NO;
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - SessionChanger
//========================================================================================================================================================
-(void)sessionChangeWithSyncKey:(NSString *)_syncKey delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[self sessionKey]						forKey:@"session_key"];
	[parameters setObject:_syncKey								forKey:@"sync_key"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"session_change" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){

			[[NSNotificationCenter defaultCenter] postNotificationName:@"sessionChanged" object:self];
			
			if ([_delegate respondsToSelector:_success]) {
				[_delegate performSelector:_success withObject:request];
			}
		}
		else {
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if ([_delegate respondsToSelector:_failure]){
				[_delegate performSelector:_failure withObject:request];
			}
		}
	}];
}
- (void) sessionChangeBackDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{

	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[self sessionKey] forKey:@"session_key"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"session_change_back" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){

			[[NSNotificationCenter defaultCenter] postNotificationName:@"sessionChanged" object:self];
			
			if([_delegate respondsToSelector:_success]) {
				[_delegate performSelector:_success withObject:request];
			}
		}
		else {
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if ([_delegate respondsToSelector:_failure]) {
				[_delegate performSelector:_failure withObject:request];
			}
		}
	}];

}
-(void)sessionInfoDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{

	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[self sessionKey] forKey:@"session_key"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"session_info" withMethod:@"get" parameters:parameters callback:^{
		
		if(request.status == 100){
			
			if ([_delegate respondsToSelector:_success]) {
				[_delegate performSelector:_success withObject:request];
			}
		}
		else {
			if(![[GHUSessionManager shared] checkResponse:request])
                return;
            
            if ([_delegate respondsToSelector:_failure]) {
				[_delegate performSelector:_failure withObject:request];
			}
		}
	}];
}
//========================================================================================================================================================
#pragma mark -
#pragma mark - SyncKey
//========================================================================================================================================================
-(void)syncKeySetEnabled:(BOOL)_enabled delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[self sessionKey] forKey:@"session_key"];
	[parameters setObject:_enabled?@"active":@"inactive" forKey:@"status"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"sync_key_update_status" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
			
			if ([_delegate respondsToSelector:_success]) {
				[_delegate performSelector:_success withObject:request];
			}
		}else {
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if ([_delegate respondsToSelector:_failure]) {
				[_delegate performSelector:_failure withObject:request];
			}
		}
	}];
}

//==============delegate Reset============================================================================================================================

- (void)syncKeyResetWithDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[self sessionKey] forKey:@"session_key"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"sync_key_reset" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
			
			if([_delegate respondsToSelector:_success]) {
				[_delegate performSelector:_success withObject:request];
			}
		}else {
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if ([_delegate respondsToSelector:_failure]) {
				[_delegate performSelector:_failure withObject:request];
			}
		}
	}];
}
//========================================================================================================================================================
#pragma mark -
#pragma mark Widget
//========================================================================================================================================================
-(void)widgetReadWithDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];	
	[parameters setObject:[self sessionKey]forKey:@"session_key"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"widget_read" withMethod:@"get" parameters:parameters callback:^{

		if(request.status == 100){
			
			if ([_delegate respondsToSelector:_success]) {
				[_delegate performSelector:_success withObject:request];
			}
		}else {
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if ([_delegate respondsToSelector:_failure]) {
				[_delegate performSelector:_failure withObject:request];
			}
		}
	}];
}
//========================================================================================================================================================
#pragma mark -
#pragma mark Global response check
//========================================================================================================================================================
-(BOOL)checkResponse:(GHUApiRequest*)request{
	
	// Checks the response of an GHURequest for status = 300, which means that session expired and the user should be logged out.
	if(request.status == 300 || [request.msg isEqualToString:@"no_session_key"]){
		[self triggerLogout];
		return NO;
	}
	else {
		return YES;
	}
}

-(BOOL)checkResponseForPermissionAndSubscription:(GHUApiRequest*)request{
	
	if(request.status == 400){
		[GHUAlertView alertWithTitle:NSLocalizedString(@"No authorization",nil) message:[NSString stringWithFormat:NSLocalizedString(@"Unfortunately, the action could not be performed because you lack the necessary authorization.\n\n The your account administrator can unlock the corresponding rights.",nil)] delegate:nil];
		
		return NO;
	}
	else if(request.status == 401){
		[GHUAlertView alertWithTitle:NSLocalizedString(@"License expired",nil) message:[NSString stringWithFormat:NSLocalizedString(@"Unfortunately, the action could not be performed because GHU your license has expired.\n\n Please renew your license under www.ghu.com (Login with your app credentials).",nil)] delegate:nil];
		
		return NO;
	}
	
	return YES;
}

-(BOOL)checkResponse:(GHUApiRequest *)request breakOnNetworkError:(NSString *)_stringOrNil{
	
	if(request.status == 300 || [request.msg isEqualToString:@"no_session_key"]){
		[self triggerLogout];
		return NO;
	}
	else if(request.status == 900){
		[GHUAlertView alertWithTitle:NSLocalizedString(@"Internet connection", nil) message:_stringOrNil?_stringOrNil:NSLocalizedString(@"Unfortunately, your request could not be processed because currently there is no connection to the Internet. Please make a connection and try again.",nil) delegate:nil];
		return NO;
	}
	else {
		return YES;
	}
}

@end
