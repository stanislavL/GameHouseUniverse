//
//  GHUDataManager.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUDataManager.h"
#import "GHUApiRequest.h"
#import "GHUSessionManager.h"
#import "GHUGameIDs.h"
#import "GHULocking.h"
#import "GHUTable.h"
#import "NSDate+ALExtended.h"
#import "NSMutableDictionary+ALExtended.h"
#import "NSDictionary+ALExtended.h"
#import "GHUAlertView.h"
#import "GHUSettingsManager.h"

@implementation GHUDataManager

static GHUDataManager* _sharedManager = nil;

@synthesize timer;
@synthesize userInfo;
@synthesize gamerProfile;
@synthesize gameidsList;
@synthesize msgList;
@synthesize communitiesList;



@synthesize aryIDs, aryImages;
@synthesize requests;
@synthesize timeArray, dateArray;

@synthesize contactsFullRunning, rsvpsFullRunning, rsvplistsFullRunning, tablesFullRunning, requestsFullRunning, fullRunning;
@synthesize contactsDiffRunning, rsvpsDiffRunning, rsvplistsDiffRunning, tablesDiffRunning, requestsDiffRunning, diffRunning;

@synthesize updateCountContacts, updateCountRsvps, updateCountRequests, updateCountRequestsInserted, updateCountRsvplists, updateCountTables, updateCountLockings, updateCountDaymetas;

@synthesize requeueFullRequest, requeueDiffRequest;
@synthesize profileRunning;

-(void)dealloc{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	_sharedManager = nil;
	
	self.timer = nil;
    self.timeArray = nil;
	self.dateArray = nil;
	
	[super dealloc];
}
+(GHUDataManager*)shared {
	
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



		// Receive notification when user logged in
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLoginNotification:) name:@"loggedIn" object:nil];
		
		// Receive notification when user logged out our session expired
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLogoutNotification:) name:@"loggedOut" object:nil];
		
		// Receive notification when a write operation (create, update, delete) to server succeeded (this should always trigger a reload of data from server)
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveWriteHappenedNotification:) name:@"writeHappened" object:nil];
		
		// Received notification when a push message has been received
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveWriteHappenedNotification:) name:@"requestNotificationReceived" object:nil];
		
		// Receive notification when a the session_context has changed and a full reload of data is required
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSessionChangedNotification:) name:@"sessionChanged" object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetData) name:@"resetData" object:nil];
		
		[self resetData];
		
		[self initTimeArray];
		[self initDateArray];
	}
	
	return self;
}

-(void)resetData{
	
	// Dictionary holding all relevant contacts received from API

	self.requests           = [[[NSMutableDictionary alloc] init] autorelease];
    self.gameidsList        = [[[NSMutableArray alloc] init] autorelease];
    self.msgList            = [[[NSMutableDictionary alloc] init]autorelease];
    self.communitiesList    = [[[NSMutableDictionary alloc] init]autorelease];
 
    
    self.userInfo        = [[[GHUUserInfo alloc] init] autorelease];
    self.aryIDs = [[NSMutableArray alloc] initWithObjects:@"Battle.netID",
                   @"GamerTag",
                   @"PNS ID",
                   @"WiiU ID",
                   @"3Ds Code",
                   @"Wargaming.net",
                   @"Softnyx",
                   @"Armor Games",
                   @"Origin ID",
                   @"Steam ID",
                   @"Twitch ID",
                   @"LolID",
                   @"Eve ID",
                   @"Minecraft ID",
                   @"Skype ID", nil];
    
    self.aryImages = [[NSMutableArray alloc] initWithObjects:@"Icon_Battlenet_ID.png",
                      @"Icon_XBOX_ID.png",
                      @"Icon_SEN_ID.png",
                      @"Icon_WiiU_ID.png",
                      @"Icon_3DS_ID.png",
                      @"Icon_Wargamingnet_ID.png",
                      @"Icon_Softnyx_ID.png",
                      @"Icon_Armorgames_ID.png",
                      @"Icon_Origin_ID.png",
                      @"Icon_Steam_ID.png",
                      @"Icon_Twitch_ID.png",
                      @"Icon_LoL_ID.png",
                      @"Icon_EVE_ID.png",
                      @"Icon_Minecraft_ID.png",
                      @"Icon_Skype_ID.png", nil];

	

	
	// Initial values of semaphors for reloading
	self.contactsFullRunning = NO;
	self.rsvpsFullRunning = NO;
	self.rsvplistsFullRunning = NO;
	self.tablesFullRunning = NO;
	self.requestsFullRunning = NO;
	self.fullRunning = NO;
	
	self.contactsDiffRunning = NO;
	self.rsvpsDiffRunning = NO;
	self.rsvplistsDiffRunning = NO;
	self.tablesDiffRunning = NO;
	self.requestsDiffRunning = NO;
	self.diffRunning = NO;
	
	// Requeue indicators
	self.requeueFullRequest = NO;
	self.requeueDiffRequest = NO;
    self.profileRunning = NO;
	// Update Counts
	[self resetUpdateCount];
	
	// Stop timer
	[self stopTimer];
}


-(void)resetUpdateCount{
	
	self.updateCountRequests			= 0;
	self.updateCountRequestsInserted	= 0;
	
	self.updateCountContacts			= 0;
	self.updateCountRsvplists			= 0;
	self.updateCountContacts			= 0;
	self.updateCountTables				= 0;
	self.updateCountLockings			= 0;
	self.updateCountDaymetas			= 0;
}

-(int)updateCount{
	
    return self.updateCountContacts + self.updateCountRequests + self.updateCountRsvplists + self.updateCountRsvps + self.updateCountTables + self.updateCountLockings + self.updateCountDaymetas;
}

#pragma mark - Notifications
-(void)didReceiveLoginNotification:(NSNotification *)notification{
	
    NSLog(@"GHUDataManager received login notification");
	
    [self loadFullData];
}

-(void)didReceiveLogoutNotification:(NSNotification *)notification{
	
    NSLog(@"GHUDataManager received logout notification");
	
    [self stopTimer];
	[self resetData];
}

-(void)didReceiveWriteHappenedNotification:(NSNotification*)notification{
	
    NSLog(@"GHUDataManager received write notification");
	
    [self loadDiffData];
}

-(void)didReceiveSessionChangedNotification:(NSNotification *)notification{
	
    NSLog(@"GHUDataManager received notification about session change");
	
    [self stopTimer];
	[self resetData];
	[self loadFullData];
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Main Operation Handler
//========================================================================================================================================================
-(void)loadDiffData{

	// Reset requeueing
	self.requeueDiffRequest = NO;
	
	if(self.diffRunning == YES){
		
		// Diff request is already running, wait for completion and trigger again.
		// Possible Reasons:
		// 1) One of the last requests failed
		// 2) Write operation happened while diff update is running
		
		self.requeueDiffRequest = YES;
	}
	else {
		
		// Reset timer to avoid race conditions where request will be triggered while old request is still running
		[self stopTimer];
		
		// Reset UpdateCounts
		[self resetUpdateCount];
		
		// Trigger reloads of all models
//		[self loadContactsDiff];
//		[self loadTablesDiff];

	}
}

-(void)loadFullData{
	
 [[NSNotificationCenter defaultCenter] postNotificationName:@"fullLoadingStarted" object:nil];
	
	//---------Reset requeueing
	self.requeueFullRequest = NO;
	
	if(self.fullRunning == YES){
		
		//------- Full request is already running, wait for completion and trigger again (reason could be that one of the requests failed)
		self.requeueFullRequest = YES;
	}else{
        
        [self loadUserInfo];
        [self loadFeedData];

    }
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Main Operation Closer
//========================================================================================================================================================
-(void)diffRequestFinished{
	
	if(self.contactsDiffRunning == YES || self.rsvpsDiffRunning == YES || self.rsvplistsDiffRunning == YES || self.tablesDiffRunning == YES || self.requestsDiffRunning == YES){
		
		// At least one of the requests is still running
		self.diffRunning = YES;
	}
	else{
		// Requests finished (we dont know if successful or with error)
		
		// Set flag
		self.diffRunning = NO;
		
		// Send notification if there are updates
		if([self updateCount] > 0){
			[[NSNotificationCenter defaultCenter] postNotificationName:@"dataUpdated" object:self];
		}
		
		// Send notification if there
		if(self.updateCountRequestsInserted > 0){
			[[NSNotificationCenter defaultCenter] postNotificationName:@"requestsReceived" object:nil];
		}
		
        if(self.requeueDiffRequest == YES){
			// If another request has been queued, trigger it after short timeout (timeout to prevent excessive infinite loop on connection errors)
			[self startTimerWithTimeInterval:10 selector:@selector(loadDiffData) repeat:NO];
			return;
		}
		else {
			// Set timeout to start next request
			[self startTimer];
		}
	}
}

- (void) fullRequestFinished{
	
	if(self.contactsFullRunning == YES || self.rsvpsFullRunning == YES || self.rsvplistsFullRunning == YES || self.tablesFullRunning == YES || self.requestsFullRunning == YES){
		
		// At least one of the requests is still running -> do nothing
		self.fullRunning = YES;
	}
	else{
		// Requests finished (we dont know if successful or with error)
		
		// Set flag
		self.fullRunning = NO;
		
		if(self.requeueFullRequest == YES){

			[self startTimerWithTimeInterval:10 selector:@selector(loadFullData) repeat:NO];
			return;
		}
		else {

            // All requests finished and we have no requeue of full notification
			[[NSNotificationCenter defaultCenter] postNotificationName:@"dataLoaded" object:self];
			
			// Set timeout to start next request
			[self startTimer];
		}
	}
}


-(void)diffRequestFailedNeedsRequeue{
	
    self.requeueDiffRequest = YES;
}

-(void)fullRequestFailedNeedsRequeue{
	
    self.requeueFullRequest = YES;
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Timer
//========================================================================================================================================================
-(void)startTimer{

	if(self.timer)
		[self.timer invalidate];
		
	self.timer = [NSTimer scheduledTimerWithTimeInterval:50 target:self selector:@selector(loadDiffData) userInfo:nil repeats:YES];
}

-(void)startTimerWithTimeInterval:(int)_interval selector:(SEL)_selector repeat:(BOOL)_repeat{
	
	if(self.timer)
		[self.timer invalidate];
		
	self.timer = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:_selector userInfo:nil repeats:_repeat];
}

-(void)stopTimer{
	
    [self.timer invalidate];
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - userInfo loading
//========================================================================================================================================================
- (void) loadUserInfo{
    
    [self.userInfo readDataFromDictionary:(NSDictionary*)[[GHUDefaultsManager shared] getUserInfo]];
     self.userInfo.imageData = (UIImage*)[[GHUDefaultsManager shared] getProfileImage];
    [self profileReadDetailsForProfile:@"profile" delegate:self success:@selector(Success:) failure:@selector(Failed:)];
    
}
- (void)Success:(GHUApiRequest*)_request{
    
    NSString* jsonString = (NSString*)[_request.data objectForKey:@"data"];
    if ([jsonString isEqual:[NSNull null]]) {
        self.profileRunning = NO;
        return;
    }
    
    NSData * jsonData = [jsonString dataUsingEncoding:NSStringEncodingConversionAllowLossy];
    NSError * error = nil;
    NSMutableArray * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    [self.gameidsList addObjectsFromArray:parsedData];
    
    NSLog(@"gameList==%@" , self.gameidsList);
    self.profileRunning = YES;
}
- (void) Failed:(GHUApiRequest*)_request{
    
    self.profileRunning = YES;
    
}
//========================================================================================================================================================
#pragma mark -
#pragma mark - Feed loading
//========================================================================================================================================================
-(void) loadFeedData{
	
	self.contactsFullRunning = YES;
  
    NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:@"feed_full" forKey:@"response_type"];
    [parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
	[parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
	
    GHUApiRequest* request = [[GHUApiRequest alloc] init];
    
	[request triggerHandler:@"feed" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
            
		
        }else{
			// save timestamp
			[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"timestamp_contacts"];

            NSLog(@"GHUDataManager loadContactsFull failed with error message: %@", request.msg);
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			

			[self fullRequestFailedNeedsRequeue];
		}
		
		// Flag that request has finished and call finish callback
        self.contactsFullRunning = NO;
        [self fullRequestFinished];
 	}];
}

- (void)loadContactsDiff{
	
	self.contactsDiffRunning = YES;
	self.diffRunning = YES;
	
	[self stopTimer];
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:@"diff" forKey:@"response_type"];
	[parameters setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"timestamp_contacts"] forKey:@"date_lastchange"];
	[parameters setObject:@"n" forKey:@"with_categories"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"contacts" withMethod:@"get" parameters:parameters callback:^{
		
		if(request.status == 100){
			
			NSLog(@"GHUDataManager updates %lu contacts", (unsigned long)[request.payload count]);
			self.updateCountContacts = (int)[request.payload count];
			



			
			// save timestamp
			[[NSUserDefaults standardUserDefaults] setObject:[request.meta objectForKey:@"date_lastchange"] forKey:@"timestamp_contacts"];
		}
		else{
			// Request failed. Current solution: requeue request on next cycle
			NSLog(@"GHUDataManager loadContactsDiff failed with msg: %@", request.msg);
		
            if(![[GHUSessionManager shared] checkResponse:request])
				return;
				
			[self diffRequestFailedNeedsRequeue];
		}
		
		// Flag that request has finished and call finish callback
		self.contactsDiffRunning = NO;
		[self diffRequestFinished];
	}];
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Locking subroutine
//========================================================================================================================================================
-(void)processLockingRequest:(NSDictionary*)_request{
	
	if([[_request stringForKey:@"status"] isEqualToString:@"full"]){
		

	}
	
	if(![_request isNullForKey:@"data"]){
	
		self.updateCountLockings = (int)[[_request objectForKey:@"data"] count];
		
		for(id _locking in (NSDictionary*)[_request objectForKey:@"data"]){
			
			GHULocking* newLocking = [[GHULocking alloc] init];
			[newLocking readDataFromDictionary:_locking];
			
			if(newLocking.date){
				

			}
			
			[newLocking release];
		}
	}
}



//========================================================================================================================================================
#pragma mark -
#pragma mark - Tables loading
//========================================================================================================================================================
-(void)loadTablesFull{
	
	self.tablesFullRunning = YES;
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:@"full" forKey:@"response_type"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
    NSLog(@"table request==%@" , parameters);
    
	[request triggerHandler:@"tables" withMethod:@"get" parameters:parameters callback:^{
		
		if(request.status == 100){
			

        // save timestamp
		[[NSUserDefaults standardUserDefaults] setObject:[request.meta objectForKey:@"date_lastchange"] forKey:@"timestamp_tables"];
        
		
        }else {
			// save timestamp
			[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"timestamp_tables"];
			
			NSLog(@"GHUDataManager loadTablesFull failed with error message: %@", request.msg);
			
            if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			// Requeue full request
			
            [self loadFullData];
			[self fullRequestFailedNeedsRequeue];
		}
		// Flag that request has finished and call finish callback
		self.tablesFullRunning = NO;
		[self fullRequestFinished];
	}];
}
//******************************************** Load Tables Diff ******************************************************
- (void) loadTablesDiff{
	
    self.tablesDiffRunning = YES;
	self.diffRunning = YES;
	[self stopTimer];
    
    NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
    [parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:@"diff" forKey:@"response_type"];
	[parameters setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"timestamp_tables"] forKey:@"date_lastchange"];

	GHUApiRequest* request = [[[GHUApiRequest alloc] init] autorelease];
	
    [request triggerHandler:@"tables" withMethod:@"get" parameters:parameters callback:^{
		
		if(request.status == 100){
			
            // save timestamp
			[[NSUserDefaults standardUserDefaults] setObject:[request.meta objectForKey:@"date_lastchange"] forKey:@"timestamp_tables"];
		}
		else {
			
            // Request failed. Current solution: requeue request
            NSLog(@"GHUDataManager loadTablesDiff failed with msg: %@", request.msg);
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
				
			[self diffRequestFailedNeedsRequeue];
		}
		// Flag that request has finished and call finish callback
		self.tablesDiffRunning = NO;
		[self diffRequestFinished];
	}];
}
//========================================================================================================================================================
#pragma mark -
#pragma mark - Contact Profile operations
//========================================================================================================================================================
//---Profile Read
-(void) profileReadDetailsForProfile:(NSString*)profile delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
    [parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
    [parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	[request triggerHandler:@"profile_read" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
			NSLog(@"GHUDataManager profile_read succeeded");
			if([_delegate respondsToSelector:_success])
				[_delegate performSelector:_success withObject:request];
		
        }else {

			NSLog(@"GHUDataManager profile_read failed with message: %@", request.msg);
            if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
				[_delegate performSelector:_failure withObject:request];
		}
	}];

}

//******************************************** Contact Profile Create ******************************************************
//--Profile Create
-(void) profileCreate:(NSString*)profile delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
    [parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
    [parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
    [parameters setObject:profile forKey:@"profile_data"];
    
    
    
    GHUApiRequest* request = [[GHUApiRequest alloc] init];
    NSLog(@"profile parameters==%@" , parameters);
     
	[request triggerHandler:@"profile_create" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){

			[[NSNotificationCenter defaultCenter] postNotificationName:@"writeHappened" object:self];
			
			if([_delegate respondsToSelector:_success])
				[_delegate performSelector:_success withObject:request];
		}else{
			

			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
				[_delegate performSelector:_failure withObject:request];
		}
	}];
}

//******************************************** Contact profile Update******************************************************
-(void) profileUpdate:(NSString*)profile delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
    [parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
    [parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
	[parameters setObject:profile forKey:@"profile_data"];

	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"profile_update" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
			NSLog(@"GHUDataManager profile_update succeeded");
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"writeHappened" object:self];
			
			if([_delegate respondsToSelector:_success])
				[_delegate performSelector:_success withObject:request];
		}else {
			NSLog(@"GHUDataManager profile_update failed with message: %@", request.msg);
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
				[_delegate performSelector:_failure withObject:request];
		}
	}];
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Locking operations
//========================================================================================================================================================
-(void)lockingUpdate:(GHULocking *)locking delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:[locking keyName] forKey:@"date"];
	[parameters setObject:(locking.shift1 ? @"1" : @"0") forKey:@"shifts[\"0\"]"];
	[parameters setObject:(locking.shift2 ? @"1" : @"0") forKey:@"shifts[\"1\"]"];
	[parameters setObject:(locking.shift3 ? @"1" : @"0") forKey:@"shifts[\"2\"]"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"locking_set" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
			NSLog(@"GHUDataManager locking_set succeeded");
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"writeHappened" object:self];
			
			if([_delegate respondsToSelector:_success])
				[_delegate performSelector:_success withObject:request];
		}
		else {
			NSLog(@"GHUDataManager locking_set failed with message: %@", request.msg);
			
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
				[_delegate performSelector:_failure withObject:request];
		}
	}];
	
}
//******************************************** Contact Locking Update ******************************************************
-(void)lockingUpdate:(GHULocking *)locking forShift:(int)_shift delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:[locking keyName] forKey:@"date"];
	[parameters setObject:[NSNumber numberWithInt:_shift-1] forKey:@"shift"];
	[parameters setObject:([locking stateForShift:_shift] ? @"1" : @"0") forKey:@"state"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"locking_set" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
			NSLog(@"GHUDataManager locking_set succeeded");
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"writeHappened" object:self];
			
			if([_delegate respondsToSelector:_success])
				[_delegate performSelector:_success withObject:request];
		}
		else {
			NSLog(@"GHUDataManager locking_set failed with message: %@", request.msg);
			
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
				[_delegate performSelector:_failure withObject:request];
		}
	}];
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Table operations
//========================================================================================================================================================
-(void)tableCreate:(GHUTable *)table delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:table.name?table.name:@""	forKey:@"name"];
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
    [request triggerHandler:@"table_create" withMethod:@"post" parameters:parameters callback:^{
		
        if(request.status == 100){
			
            NSLog(@"GHUDataManager table_create succeeded");
			[[NSNotificationCenter defaultCenter] postNotificationName:@"writeHappened" object:self];
			
			if([_delegate respondsToSelector:_success])
				[_delegate performSelector:_success withObject:request];
		
        }else{
			
            NSLog(@"GHUDataManager contact_create failed with message: %@", request.msg);
			
            if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
                [_delegate performSelector:_failure withObject:request];
		}
	}];
}

//******************************************** Table Update ******************************************************
-(void)tableUpdate:(GHUTable *)table delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:table.table_id			forKey:@"table_id"];
	[parameters setObject:table.name?table.name:@""	forKey:@"name"];
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	[request triggerHandler:@"table_update" withMethod:@"post" parameters:parameters callback:^{
		
		if(request.status == 100){
			NSLog(@"GHUDataManager table_update succeeded");
			[[NSNotificationCenter defaultCenter] postNotificationName:@"writeHappened" object:self];
			
			if([_delegate respondsToSelector:_success])
				
                [_delegate performSelector:_success withObject:request];
		}else {
			NSLog(@"GHUDataManager contact_update failed with message: %@", request.msg);
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
				
                [_delegate performSelector:_failure withObject:request];
		}
	}];
}
//******************************************** Table Delete******************************************************
- (void)tableDelete:(GHUTable *)table delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:table.table_id forKey:@"table_id"];
    GHUApiRequest* request = [[GHUApiRequest alloc] init ];

    [request triggerHandler:@"table_delete" withMethod:@"get" parameters:parameters callback:^{
		
		if(request.status == 100){
            
            NSLog(@"GHUDataManager table_delete succeeded");
			[[NSNotificationCenter defaultCenter] postNotificationName:@"writeHappened" object:self];
			
			if([_delegate respondsToSelector:_success])
				[_delegate performSelector:_success withObject:request];
		
        }else {
		
            NSLog(@"GHUDataManager contact_delete failed with message: %@", request.msg);
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
				[_delegate performSelector:_failure withObject:request];
		}
	}];
}
//========================================================================================================================================================
#pragma mark -
#pragma mark - Table Plan operations
//========================================================================================================================================================
-(void)tablePlanUploadImage:(UIImage*)_image delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSData* _imageData = UIImageJPEGRepresentation(_image, 0.8);
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	NSMutableDictionary* data = [[[NSMutableDictionary alloc] init] autorelease];
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[data setObject:_imageData forKey:@"image"];
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"tableplan_upload" withParameters:parameters andData:data callback:^{
		
		if(request.status == 100){
			NSLog(@"GHUDataManager tableplan_upload succeeded");
			
			if([_delegate respondsToSelector:_success])
				[_delegate performSelector:_success withObject:request];
		}
		else {
			NSLog(@"GHUDataManager tableplan_upload failed with message: %@", request.msg);
			
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
				[_delegate performSelector:_failure withObject:request];
		}
	}];
}

-(void)tablePlanReadDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"tableplan_read" withMethod:@"get" parameters:parameters callback:^{
		
		if(request.status == 100){
			
            NSLog(@"GHUDataManager tableplan_read succeeded");
			if([_delegate respondsToSelector:_success])
				[_delegate performSelector:_success withObject:request];
		}
        else
        {
			NSLog(@"GHUDataManager tableplan_read failed with message: %@", request.msg);
			
			if(![[GHUSessionManager shared] checkResponse:request])
				return;
			
			if([_delegate respondsToSelector:_failure])
				[_delegate performSelector:_failure withObject:request];
		}
	}];
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Time and Date arrays
//========================================================================================================================================================
- (void) initDateArray{
	
	if(!self.dateArray)
		self.dateArray = [[[NSMutableArray alloc] init] autorelease];
	
	for (int i=1; i<365; i++) {
		[self.dateArray addObject:[[[NSDate date] addDays:(int)[NSNumber numberWithInt:i-183]] simplifyToDate]];
	}
}

- (void) initTimeArray{
	
	if(!self.timeArray)
		self.timeArray = [[[NSMutableArray alloc] init] autorelease];
	
	NSDate* baseDate = [NSDate dateFromString:@"2014-10-10 00:00:00"];
	
	for (int i=0; i<24*4; i++){
		[self.timeArray addObject:[[baseDate dateByAddingTimeInterval:15*60*i] simplifyToTime]];
	}
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Game Name list Getting
//========================================================================================================================================================
- (NSMutableArray*) readFromGameList:(NSString*) idsName{
    
    if (!idsName) {
        return nil;
    }
    
    NSString* path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt" , idsName]];
    
    NSString* fileContent = [self readFromFile:path];
    NSArray* arryString = [[NSArray alloc] init];
    
    arryString = [fileContent componentsSeparatedByString:@","];
    
    NSMutableArray* aryGameList= [[NSMutableArray alloc] initWithArray:arryString copyItems:YES ];
    
    NSLog(@"idsName== %@ , array = %@" , idsName, aryGameList);
    
    return aryGameList;
    
}
- (NSString*) readFromFile:(NSString *)fileName{
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:fileName])
    {
        NSString* data = [[NSString alloc] initWithContentsOfFile:fileName encoding:NSASCIIStringEncoding error:nil];
        
        return data;
        
    }else
    {
        return nil;
    }
    
}


@end
