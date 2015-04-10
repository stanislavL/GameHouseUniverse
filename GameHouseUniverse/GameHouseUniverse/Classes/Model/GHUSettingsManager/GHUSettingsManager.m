//
//  GHUSettingsManager.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "GHUSettingsManager.h"
#import "NSDictionary+ALExtended.h"

@implementation GHUSettingsManager

@synthesize settings;

static GHUSettingsManager* _sharedManager = nil;

+(GHUSettingsManager*)shared {
	
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
		[self loadSettingsFromPlist];
	}
	return self;
}

-(void)loadSettingsFromPlist{
	
    NSString *path=[[NSBundle mainBundle] pathForResource:@"GHUSettings" ofType:@"plist"];
	self.settings=[NSDictionary dictionaryWithContentsOfFile:path];
}

-(id)getString:(NSString*)key{
	
    return [self.settings stringForKey:key];
}

- (BOOL)inAppPurchases{
	
    return [[self.settings objectForKey:@"inAppPurchases"] boolValue];
}

- (BOOL)isGHU{
	
    return [[self.settings objectForKey:@"product"] isEqualToString:@"ghu"];
}

- (BOOL)QRScanner{
	
    return [[self.settings objectForKey:@"QRScanner"] boolValue];
}

- (NSString*)bundleId{
	
    return [self getString:@"bundleId"];
}

- (NSString*)product{

	return [self getString:@"product"];
}

- (NSArray*)colorArray:(NSString*)_identifier{
	
    return (NSArray*)[(NSDictionary*)[self.settings objectForKey:@"colors"] objectForKey:_identifier];
}

- (NSString*)versionAndBuildNumber{
	
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
	return [NSString stringWithFormat:@"%@ (%@)", [appInfo objectForKey:@"CFBundleShortVersionString"], [appInfo objectForKey:@"CFBundleVersion"]];
}

- (NSString*)versionBuildNumberAndBundleId{

	NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
	
    return [NSString stringWithFormat:@"%@ (%@) %@", [appInfo objectForKey:@"CFBundleShortVersionString"], [appInfo objectForKey:@"CFBundleVersion"], [appInfo objectForKey:@"CFBundleIdentifier"]];
}

- (NSString*)appId{
	
    return [self getString:@"appId"];
}

- (NSString*)localeLanguageCode{

    NSString *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];
	
	if([countryCode isEqualToString:@"de"]){
		return @"de";
	}
	else{
		return @"en";
	}
}

-(void)dealloc{
	
    self.settings = nil;
	return [super dealloc];
}

@end
