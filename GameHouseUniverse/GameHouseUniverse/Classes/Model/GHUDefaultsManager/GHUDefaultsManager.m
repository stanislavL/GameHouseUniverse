//
//  GHUDefaultsManager.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUDefaultsManager.h"
#import "NSString+ALExtended.h"

@implementation GHUDefaultsManager

static GHUDefaultsManager* _sharedManager = nil;

@synthesize defaults;

- (void) dealloc{
	self.defaults = nil;
	[super dealloc];
}

+(GHUDefaultsManager*)shared {
	
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
		self.defaults = [NSUserDefaults standardUserDefaults];
	}
	
	return self;
}

-(void)setSessionKey:(NSString *)_sessionKey{

	[self.defaults setObject:_sessionKey forKey:@"sessionKey"];
}

-(NSString*)sessionKey{
	
    return [self.defaults objectForKey:@"sessionKey"];
}

-(void)setLoggedIn:(BOOL)_loggedIn{
	
    [self.defaults setBool:_loggedIn forKey:@"loggedIn"];
}

-(BOOL)loggedIn{
	
    return [self.defaults boolForKey:@"loggedIn"];
}
- (void) setUserInfo:(GHUUserInfo*) info{

    NSMutableDictionary* data = [[[NSMutableDictionary alloc] init] autorelease];
    [data setObject:info.username forKey:@"username"];
    [data setObject:info.email forKey:@"email"];
    [data setObject:info.pwd forKey:@"pwd"];
    [data setObject:info.memberDate forKey:@"date"];
    [self.defaults setObject:data forKey:@"data"];
}
- (NSDictionary*) getUserInfo{
    
    
    return (NSDictionary*)[self.defaults objectForKey:@"data"];
}
//**************** Profile Data*************************
//--------image-------
-(void) setProfileImage:(UIImage*) image{
    
    [self.defaults setObject:UIImagePNGRepresentation(image) forKey:@"profileImage"];
    
}
-(UIImage*) getProfileImage{
    
    NSData* imageData = [self.defaults objectForKey:@"profileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
}
//------------data
-(void) setProfileData:(NSMutableArray*) data{
    [self.defaults setObject:data forKey:@"profile"];
    
}
-(NSMutableArray*) ProfileData{
    
    return (NSMutableArray*)[self.defaults objectForKey:@"profile"];
}

-(void)setApnsEnabled:(BOOL)_apnsEnabled{
	
    [self.defaults setBool:_apnsEnabled forKey:@"apnsEnabled"];
}

-(BOOL)apnsEnabled{
	
    return [self.defaults boolForKey:@"apnsEnabled"];
}

-(void)setApnsPending:(BOOL)_apnsPending{
	
    [self.defaults setBool:_apnsPending forKey:@"apnsPending"];
}

-(BOOL)apnsPending{
	
    return [self.defaults boolForKey:@"apnsPending"];
}

-(void)setApnsSent:(BOOL)_apnsSent{
	
    [self.defaults setBool:_apnsSent forKey:@"apnsSent"];
}

-(BOOL)apnsSent{
	
    return [self.defaults boolForKey:@"apnsSent"];
}

-(void)setDeviceToken:(NSString *)_deviceToken{
	
    if(!_deviceToken)
		[self.defaults removeObjectForKey:@"deviceToken"];
	else
		[self.defaults setObject:_deviceToken forKey:@"deviceToken"];
}

-(NSString*)deviceToken{
	
    return [[self.defaults stringForKey:@"deviceToken"] withPlaceholder:@""];
}

-(BOOL)introSeen{
	
    return [self.defaults boolForKey:@"introSeen"];
}

-(void)setIntroSeen:(BOOL)_seen{
	
    [self.defaults setBool:_seen forKey:@"introSeen"];
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - Columns
//======================================================================================================================================================================

-(void)setColumnStoreInitialized:(BOOL)_initialized{
	
    [self.defaults setBool:_initialized	forKey:@"columnStoreInitialized"];
}

-(BOOL)columnStoreInitialized{
	return [self.defaults boolForKey:@"columnStoreInitialized"];
}

-(void)columnStoreSetColumnId:(NSString*)_columnId forKey:(NSString*)_key{
	
	NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:[self.defaults dictionaryForKey:@"columnStore"]];
    if(!dict){
		dict = [[[NSMutableDictionary alloc] init] autorelease];
	}
	
	[dict setValue:_columnId forKey:_key];
	
	[self.defaults setValue:dict forKey:@"columnStore"];
}

-(NSString*)columnStoreColumnIdForKey:(NSString*)_key{
	
    return (NSString*)[[self.defaults dictionaryForKey:@"columnStore"] objectForKey:_key];
}
//======================================================================================================================================================================
#pragma mark -
#pragma mark - TextTemplates
//======================================================================================================================================================================
-(NSString*)textTemplateRequestAccept{
	
    return [[self.defaults stringForKey:@"textTemplateRequestAccept"] withPlaceholder:@""];
}

-(void)setTextTemplateRequestAccept:(NSString*)_text{
	
    [self.defaults setObject:_text forKey:@"textTemplateRequestAccept"];
}

-(NSString*)textTemplateRequestReject{
	
    return [[self.defaults stringForKey:@"textTemplateRequestReject"] withPlaceholder:@""];
}

-(void)setTextTemplateRequestReject:(NSString*)_text{

	[self.defaults setObject:_text forKey:@"textTemplateRequestReject"];
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - Customline
//======================================================================================================================================================================


-(NSString*)customLine{
	return [[self.defaults stringForKey:@"customLine"] withPlaceholder:@""];
}

-(void)setCustomLine:(NSString*)_text{
	
    [self.defaults setObject:_text forKey:@"customLine"];
}


@end
