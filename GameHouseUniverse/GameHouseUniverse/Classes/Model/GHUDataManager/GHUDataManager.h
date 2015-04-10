//
//  GHUDataManager.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <Foundation/Foundation.h>
#import "GHUGameIDs.h"
#import "GHUTable.h"
#import "GHULocking.h"
#import "GHUUserInfo.h"
#import "GHUDefaultsManager.h"


@interface GHUDataManager : NSObject{
	
	NSTimer* timer;
    
	NSMutableArray* gameidsList;
	NSMutableDictionary* msgList;
	NSMutableDictionary* communitiesList;
	NSMutableDictionary* requests;

	
	NSMutableSet* prePendingCheckinQueue; // stores 
	NSMutableDictionary* pendingCheckins;
    
  
	
	// Counter for updates
	int updateCountContacts;
	int updateCountRsvps;
	int updateCountTables;

	int updateCountRequests;
	int updateCountRequestsInserted;
	int updateCountRsvplists;
	int updateCountLockings;
	int updateCountDaymetas;
	
	NSMutableArray* dateArray;
	NSMutableArray* timeArray;
	
	BOOL contactsFullRunning;
	BOOL rsvpsFullRunning;
	BOOL tablesFullRunning;
	BOOL requestsFullRunning;
	BOOL rsvplistsFullRunning;
	BOOL fullRunning;
    BOOL contactsDiffRunning;
    BOOL rsvpsDiffRunning;
    BOOL tablesDiffRunning;
	BOOL requestsDiffRunning;
	BOOL rsvplistsDiffRunning;
	BOOL diffRunning;
	
	BOOL requeueFullRequest;
	BOOL requeueDiffRequest;
    BOOL profileRunning;
    
    GHUUserInfo* userInfo;
    GHUGameIDs* gamerProfile;
}

@property (nonatomic, retain) GHUUserInfo* userInfo;
@property (nonatomic, retain) GHUGameIDs* gamerProfile;
@property (nonatomic, retain) NSMutableArray* gameidsList;
@property (nonatomic, retain) NSMutableDictionary* msgList;
@property (nonatomic, retain) NSMutableDictionary* communitiesList;
@property (nonatomic, retain) NSMutableDictionary* requests;

@property (nonatomic, retain) NSMutableArray* aryIDs;
@property (nonatomic, retain) NSMutableArray* aryImages;
 

@property (nonatomic, retain) NSTimer* timer;

@property (nonatomic, assign) int updateCountContacts;
@property (nonatomic, assign) int updateCountRsvps;
@property (nonatomic, assign) int updateCountTables;
@property (nonatomic, assign) int updateCountRequests;
@property (nonatomic, assign) int updateCountRequestsInserted;
@property (nonatomic, assign) int updateCountRsvplists;
@property (nonatomic, assign) int updateCountLockings;
@property (nonatomic, assign) int updateCountDaymetas;

@property (nonatomic, retain) NSMutableArray* timeArray;
@property (nonatomic, retain) NSMutableArray* dateArray;

@property (nonatomic, assign) BOOL contactsFullRunning;
@property (nonatomic, assign) BOOL rsvpsFullRunning;
@property (nonatomic, assign) BOOL rsvplistsFullRunning;
@property (nonatomic, assign) BOOL tablesFullRunning;
@property (nonatomic, assign) BOOL requestsFullRunning;
@property (nonatomic, assign) BOOL fullRunning;

@property (nonatomic, assign) BOOL contactsDiffRunning;
@property (nonatomic, assign) BOOL rsvpsDiffRunning;
@property (nonatomic, assign) BOOL rsvplistsDiffRunning;
@property (nonatomic, assign) BOOL tablesDiffRunning;
@property (nonatomic, assign) BOOL requestsDiffRunning;
@property (nonatomic, assign) BOOL diffRunning;

@property (nonatomic, assign) BOOL requeueFullRequest;
@property (nonatomic, assign) BOOL requeueDiffRequest;
@property (nonatomic, assign) BOOL profileRunning;


+(GHUDataManager*) shared;

-(void) resetData;
-(void) loadFullData;



-(void) processLockingRequest:(NSDictionary*)_request;

-(void) diffRequestFinished;
-(void) fullRequestFinished;


-(void) didReceiveLoginNotification:(NSNotification*)notification;
-(void) didReceiveLogoutNotification:(NSNotification*)notificatiion;
-(void) didReceiveWriteHappenedNotification:(NSNotification*)notificatiion;
-(void) didReceiveSessionChangedNotification:(NSNotification*)notification;

-(void) startTimer;
-(void) stopTimer;

-(void) profileReadDetailsForProfile:(NSString*)profile delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void) profileCreate:(NSString*)profile delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void) profileUpdate:(NSString*)profile delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;

-(void) lockingUpdate:(GHULocking*)locking delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;

-(void) lockingUpdate:(GHULocking*)locking forShift:(int)_shift delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;



-(void) tableCreate:(GHUTable*)table delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void) tableUpdate:(GHUTable*)table delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void) tableDelete:(GHUTable*)table delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;

-(void) tablePlanReadDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void) tablePlanUploadImage:(UIImage*)_image delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;

//=================Getting gamelist from .txt file=================================
- (NSMutableArray*) readFromGameList:(NSString*) idsName;
- (NSString*) readFromFile:(NSString *)fileName;



@end
