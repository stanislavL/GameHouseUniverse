//
//  GHUApiRequest.m
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//


#import "GHUApiRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "NSDictionary+UrlEncoding.h"
#import "NSDictionary+ALExtended.h"
#import <StoreKit/StoreKit.h>

@implementation GHUApiRequest

@synthesize gameIds;
@synthesize userID,createdDate, msg, meta, status, handler, sessionID;
@synthesize delegate, selector;
@synthesize data;

-(void)dealloc{
	
	NSLog(@"GHUApiRequest dealloc");
	
    self.userID = nil;
    self.createdDate = nil;
	self.msg = nil;
    self.sessionID = nil;
	self.meta = nil;
	self.delegate = nil;
	self.selector = nil;
	self.handler = nil;
	
	[super dealloc];
}

-(GHUApiRequest*)init{

	self = [super init];
	
	if(self){
		self.selector = @selector(requestDidFinish:);
	}
	
	return self;
}

- (void) postParameters:(NSDictionary*)parameters withHandler:(NSString*)aHandler{
	
	self.handler = aHandler;
	
	NSMutableString *requestUrl = [NSMutableString stringWithFormat:@"http://ec2-54-84-18-144.compute-1.amazonaws.com?handler=%@", aHandler];
	
	ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:requestUrl]];
	
	[req setRequestMethod:@"POST"];
	
	for(id key in parameters){
		[req setPostValue:[parameters objectForKey:key] forKey:key];
	}

	[req setDelegate:self];
	[req startAsynchronous];
}

- (void) postParameters:(NSDictionary*)_parameters andData:(NSDictionary*)_data withHandler:(NSString*)_handler{
	
	self.handler = _handler;
	
	NSMutableString *requestUrl = [NSMutableString stringWithFormat:@"http://ec2-54-84-18-144.compute-1.amazonaws.com?handler=%@", _handler];
	
	ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:requestUrl]];
	
	[req setRequestMethod:@"POST"];
	
	for(id key in _parameters){
		
        [req setPostValue:[_parameters objectForKey:key] forKey:key];
	}
	
	int counter = 0;
	for(id key in _data){
	
        [req addData:_data withFileName:[NSString stringWithFormat:@"file%i", counter++] andContentType:@"image/jpeg" forKey:(NSString*)key];
	}
	[req setDelegate:self];
	[req startAsynchronous];
}
-(void)getParameters:(NSDictionary *)parameters withHandler:(NSString *)aHandler{
	
	self.handler = aHandler;
	
	NSString *query = [parameters urlEncodedString];
	NSMutableString *requestUrl = [NSMutableString stringWithFormat:@"http://ec2-54-84-18-144.compute-1.amazonaws.com?handler=%@&%@", aHandler, query];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestUrl]];
	
	[req setRequestMethod:@"GET"];
	
	[req setDelegate:self];
	[req startAsynchronous];
}

- (void)getLoggedInParameters:(NSDictionary *)parameters withHandler:(NSString *)aHandler{
	
	NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
	
	[self getParameters:newParameters withHandler:aHandler];
}

- (void)postLoggedInParameters:(NSDictionary *)parameters withHandler:(NSString *)aHandler{
	
	NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
	[self postParameters:newParameters withHandler:aHandler];
}
- (void)triggerHandler:(NSString *)_handler withMethod:(NSString *)_method parameters:(NSDictionary *)_parameters delegate:(id)_delegate selector:(SEL)_selector{
	
	self.delegate = _delegate;
	self.selector = _selector;
	
    if([_method isEqualToString:@"get"]){
		[self getParameters:_parameters withHandler:_handler];
	}else{
        [self postParameters:_parameters withHandler:_handler];
	}
}

- (void)triggerHandler:(NSString*)_handler withParameters:(NSDictionary*)_parameters andData:(NSDictionary*)_data delegate:(id)_delegate selector:(SEL)_selector{
	
	self.delegate = _delegate;
	self.selector = _selector;
	[self postParameters:_parameters andData:_data withHandler:_handler];
}

//=====================================================================================================================================
#pragma mark -
#pragma mark - Login/SignUp request method with parameters and method(get or post)
//=====================================================================================================================================

-(void)triggerHandler:(NSString*)_handler withMethod:(NSString *)_method parameters:(NSDictionary*)_parameters callback:(void(^)(void))_callback{
	
	self.handler = _handler;
	
    __block ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://ec2-54-84-18-144.compute-1.amazonaws.com"]];
	
	
    if([_method isEqualToString:@"get"]){
		
        [request setRequestMethod:@"GET"];
		
		NSString *query = [_parameters urlEncodedString];

		NSMutableString *requestUrl = [NSMutableString stringWithFormat:@"http://ec2-54-84-18-144.compute-1.amazonaws.com?handler=%@&%@", _handler, query];
		
		[request setURL:[NSURL URLWithString:requestUrl]];
	
    }else{
		
        [request setRequestMethod:@"POST"];
		for(id key in _parameters){
			
            [request setPostValue:[_parameters objectForKey:key] forKey:key];
		}
        
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ec2-54-84-18-144.compute-1.amazonaws.com:80?handler=%@", _handler]]];
	}
	
	[request setCompletionBlock:^{
		
		NSString *responseString = [request responseString];
     
        NSLog(@"Response String:%@" , responseString);
		
        NSDictionary* dict = [responseString objectFromJSONString];
        
		
		if(!dict){
            self.status = 900;
			self.msg = @"response_is_no_valid_json";
			self.meta = nil;
        }else{
            
            self.data = dict;
            self.status = [[dict objectForKey:@"status"] intValue];
			self.msg = [dict stringForKey:@"msg"];
            self.sessionID = [dict stringForKey:@"session_key"];
			self.meta = (NSDictionary*)[dict objectForKey:@"data"];
            self.userID = [dict stringForKey:@"username"];
            self.createdDate = [dict stringForKey:@"createdDate"];
    
            
		}

		_callback();
		[self release];
	
    }];
    [request setFailedBlock:^{
		
		self.msg = @"request_failed";
		self.status = 900;
		self.meta = nil;
		
		NSLog(@"request to handler=%@, status=%d, msg=%@", self.handler, self.status, self.msg);
		
		_callback();
		[self release];
	}];
	
	[request startAsynchronous];
}


- (void)triggerHandler:(NSString*)_handler withParameters:(NSDictionary*)_parameters andData:(NSDictionary*)_data callback:(void(^)(void))_callback{
	
	self.handler = _handler;
	
	__block ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://ec2-54-84-18-144.compute-1.amazonaws.com"]];
	[request setRequestMethod:@"POST"];
		
	for(id key in _parameters){
		
        [request setPostValue:[_parameters objectForKey:key] forKey:key];
	}
	
	int counter = 0;
	
	for(id key in _data){
		
        [request addData:[_data objectForKey:key] withFileName:[NSString stringWithFormat:@"file%i", counter++] andContentType:@"image/jpeg" forKey:@"file"];
	}
		
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ec2-54-84-18-144.compute-1.amazonaws.com?handler=%@", _handler]]];
     
	
	[request setCompletionBlock:^{
        NSString *responseString = [request responseString];
		NSDictionary* dict = [responseString objectFromJSONString];
        NSLog(@"responstString _From Data==%@" , responseString);
        
        if(!dict){
			self.status = 900;
			self.msg = @"response_is_no_valid_json";
			self.meta = nil;
		
        }else{
            self.status = [[dict objectForKey:@"status"] intValue];
			self.msg = [dict stringForKey:@"msg"];
			self.meta = (NSDictionary*)[dict objectForKey:@"data"];
		}
		
		NSLog(@"request to handler=%@, status=%d, msg=%@", self.handler, self.status, self.msg);
		
		_callback();
		[self release];
	}];
	
	[request setFailedBlock:^{
		
		self.msg = @"request_failed";
		self.status = 900;

		self.meta = nil;
		
		NSLog(@"request to handler=%@, status=%d, msg=%@", self.handler, self.status, self.msg);
		
		_callback();
		
		[self release];
	}];
	
	[request startAsynchronous];
}
//********************************************************************** request finished **********************************************************************
- (void)requestFinished:(ASIHTTPRequest*)_request{

	NSString *responseString = [_request responseString];
	NSDictionary* dict = [responseString objectFromJSONString];

    if(!dict){
		
        self.status = 900;
		self.msg = @"response_is_no_valid_json";
		self.meta = nil;
	
    }else{
		self.status = [[dict objectForKey:@"status"] intValue];
		self.msg = [dict stringForKey:@"msg"];
		self.meta = (NSDictionary*)[dict objectForKey:@"meta"];
	}
	
	NSLog(@"request to handler=%@, status=%d, msg=%@", self.handler, self.status, self.msg);
	
	[self autorelease];
	
	if([self.delegate respondsToSelector:self.selector]){
        [self.delegate performSelector:self.selector withObject:self];
	}
}
//********************************************************************** request failed **********************************************************************

-(void)requestFailed:(ASIHTTPRequest*)_request{

	self.msg = @"request_failed";
	self.status = 900;
	self.meta = nil;
	
	NSLog(@"request to handler=%@, status=%d, msg=%@", self.handler, self.status, self.msg);
	
	[self autorelease];
	
	if([self.delegate respondsToSelector:self.selector]){
		
        [self.delegate performSelector:self.selector withObject:self];
	}
	
}

@end
