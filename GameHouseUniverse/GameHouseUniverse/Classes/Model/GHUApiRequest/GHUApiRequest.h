//
//  GHUApiRequest.h
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import "ASIHTTPRequest.h"
#import "GHUUserInfo.h"
#import "GHUGameIDs.h"


@interface GHUApiRequest : NSObject {

    int status;
    GHUUserInfo* userInfo;
	NSString *msg;
    NSString *userID;
    NSString *sessionID;
    
	NSDictionary *meta;
    NSDictionary* data;
    
    NSString* createdDate;
	NSString *handler;
	
    id delegate;
	SEL selector;
}


@property (nonatomic, assign) int status;
@property (nonatomic, copy) GHUGameIDs* gameIds;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *msg;
@property (nonatomic, retain) NSString* createdDate;
@property (nonatomic, retain) NSDictionary *payload;
@property (nonatomic, retain) NSString *sessionID;
@property (nonatomic, retain) NSDictionary *meta;
@property (nonatomic, retain) NSDictionary* data;
@property (nonatomic, retain) NSString *handler;
@property (nonatomic, retain) id delegate;
@property (nonatomic, assign) SEL selector;

-(void)postParameters:(NSDictionary*)parameters withHandler:(NSString*)aHandler;
-(void)getParameters:(NSDictionary*)parameters withHandler:(NSString*)aHandler;

-(void)getLoggedInParameters:(NSDictionary*)parameters withHandler:(NSString*)aHandler;
-(void)postLoggedInParameters:(NSDictionary*)parameters withHandler:(NSString*)aHandler;

-(void)triggerHandler:(NSString*)_handler withMethod:(NSString*)_method parameters:(NSDictionary*)_parameters delegate:(id)_delegate selector:(SEL)_selector;
-(void)triggerHandler:(NSString*)_handler withParameters:(NSDictionary*)_parameters andData:(NSDictionary*)_data delegate:(id)_delegate selector:(SEL)_selector;


-(void)triggerHandler:(NSString*)_handler withMethod:(NSString*)_method parameters:(NSDictionary*)_parameters callback:(void(^)(void))_callback;
-(void)triggerHandler:(NSString*)_handler withParameters:(NSDictionary*)_parameters andData:(NSDictionary*)_data callback:(void(^)(void))_callback;

//request finish
-(void)requestFinished:(ASIHTTPRequest*)_request;
-(void)requestFailed:(ASIHTTPRequest*)_request;
@end



