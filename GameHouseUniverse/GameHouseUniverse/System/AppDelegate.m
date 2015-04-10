//
//  AppDelegate.m
//  GameHouseUniverse
//
//  Created by stanislav on 13/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "GHUDataManager.h"
#import "GHUSessionManager.h"
#import "GHUScreenManager.h"
#import "GHUSessionManager.h"
#import "GHUSettingsManager.h"
#import "GHUAPNSManager.h"
#import "GHUViewController.h"


float fx;
float fy;
CGSize winSize;
BOOL enableProfile;

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize session;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    self.window.rootViewController = [[[UINib nibWithNibName:[self getDeviceString:@"MainWindow"] bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.window makeKeyAndVisible];
    
    
    [FBProfilePictureView class];
    //*************************devices scale get **********************************
    winSize = self.window.frame.size;
    fx = winSize.width / 768;
    fy = winSize.height / 1024;
    //*****************************************************************************
    
    enableProfile = NO;
    [GHUDataManager shared];
    
    [[GHUScreenManager shared] initRootViewController:self.window.rootViewController];
    [[GHUSessionManager shared] startUp];
    [[GHUAPNSManager shared] registerForRemoteNotifications];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[GHUAPNSManager shared] initiateSendingOfPendingDeviceToken];
    
    //=============Facebook app start=============
    [[FBSession  activeSession] handleDidBecomeActive];
    
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{


}
#pragma mark-
#pragma mark - Get DevicesName
//===================================================================================================================================
- (NSString*) getDeviceString:(NSString*) vcName{
    
    NSString* strName = [[[NSString alloc] init] autorelease];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        strName = [NSString stringWithFormat:@"%@~iPhone" , vcName];
    }else{
        strName = [NSString stringWithFormat:@"%@~iPad" , vcName];
    }
    
    return strName;
}

#pragma mark -
#pragma mark APNS delegates
//===================================================================================================================================
- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  
    [[GHUAPNSManager shared] receiveDeviceTokenSuccessForApp:application deviceToken:deviceToken];
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    [[GHUAPNSManager shared] receiveDeviceTokenFailureForApp:application error:error];
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [[GHUAPNSManager shared] didReceiveRemoteNotification:userInfo];
}

#pragma mark -
#pragma mark FaceBook Session Start
//===================================================================================================================================
- (BOOL) application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation{
    
    return [[FBSession activeSession] handleOpenURL:url];
}

- (void) dealloc{
    
    [_window release];
    [super dealloc];
}

float buttonsPosition[10][2] = {
    {210.0f, 105.0f},{237.0f, 145.0f},{264.0f, 185.0f},{237.0f, 225.0f},{210.0f, 265.0f},
    {76.0f, 105.0f},{47.0f, 145.0f},{20.0f, 185.0f},{47.0f, 225.0f},{76.0f,265.0f}
};

float btnPos[10][2] = {
    {220,100},{242,135},{261,170},{242,205},{220,240},
    {65,100},{42,135},{23,170},{42,205},{65,240}
};

@end
