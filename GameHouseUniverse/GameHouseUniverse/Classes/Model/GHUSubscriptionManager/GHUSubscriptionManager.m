//
//  GHUSubscriptionManager.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "GHUSubscriptionManager.h"
#import "GHUApiRequest.h"
#import "GHUSettingsManager.h"
#import "GHUDefaultsManager.h"
#import "GHUSessionManager.h"

@implementation GHUSubscriptionManager

static GHUSubscriptionManager* _sharedManager = nil;

-(void)dealloc{
	[super dealloc];
}

+(GHUSubscriptionManager*)shared {
	
	@synchronized(self){
		if(_sharedManager == NULL){
			_sharedManager = [[self alloc] init];
		}
	}
	
	return(_sharedManager);
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark Subscriptions
//======================================================================================================================================================================

-(void)subscriptionsDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
	[parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"subscriptions_ios" withMethod:@"get" parameters:parameters callback:^{
		
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

-(void)subscriptionProcessWithAppStoreIdentifier:(NSString *)_identifier receiptData:(NSString*)_receiptData delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
    [parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
	[parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
	[parameters setObject:_identifier forKey:@"app_store_identifier"];
	[parameters setObject:_receiptData forKey:@"receipt_data"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"subscription_process_iap" withMethod:@"post" parameters:parameters callback:^{
		
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

-(void)subscriptionRedeemVoucher:(NSString *)_voucher delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure{
	
	NSMutableDictionary* parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setObject:[[GHUSessionManager shared] sessionKey] forKey:@"session_key"];
	[parameters setObject:[[GHUSettingsManager shared] product] forKey:@"product"];
	[parameters setObject:[[GHUSettingsManager shared] bundleId] forKey:@"bundle_id"];
	[parameters setObject:_voucher forKey:@"voucher_key"];
	
	GHUApiRequest* request = [[GHUApiRequest alloc] init];
	
	[request triggerHandler:@"subscription_voucher_redeem" withMethod:@"post" parameters:parameters callback:^{
		
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

@end