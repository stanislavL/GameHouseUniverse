//
//  GHUSubscriptionManager.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import <Foundation/Foundation.h>

@interface GHUSubscriptionManager : NSObject {
	
}

+(GHUSubscriptionManager*)shared;

-(void)subscriptionsDelegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void)subscriptionProcessWithAppStoreIdentifier:(NSString*)_identifier receiptData:(NSString*)_receiptData delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;
-(void)subscriptionRedeemVoucher:(NSString*)_voucher delegate:(id)_delegate success:(SEL)_success failure:(SEL)_failure;

@end
