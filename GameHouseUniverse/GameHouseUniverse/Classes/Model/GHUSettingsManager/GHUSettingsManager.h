//
//  GHUSettingsManager.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import <Foundation/Foundation.h>

@interface GHUSettingsManager : NSObject {
	NSDictionary* settings;
}

+ (GHUSettingsManager*)shared;
- (id)getString:(NSString*)key;

- (BOOL)inAppPurchases;
- (BOOL)isGHU;
- (BOOL)QRScanner;

- (NSString*)bundleId;
- (NSString*)product;
- (NSArray*)colorArray:(NSString*)_identifier;
- (NSString*)versionAndBuildNumber;
- (NSString*)versionBuildNumberAndBundleId;
- (NSString*)appId;

- (NSString*)localeLanguageCode;

@property (nonatomic, retain) NSDictionary* settings;

@end
