//
//  GHUScreenManager.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface GHUScreenManager : NSObject{
	
    UIViewController* rootViewController;
    AppDelegate* delegate;
    
}

@property (nonatomic, retain) UIViewController* rootViewController;

+(GHUScreenManager*)shared;
+(BOOL)isIPad;

-(void)initRootViewController:(UIViewController*)_viewController;
-(void)registerForNotifications;
-(void)goToScreen:(NSString*)screen;

//------Login or Logou notification----------
-(void)didReceiveLogoutNotification:(NSNotification*)_notification;
-(void)didReceiveLoginNotification:(NSNotification*)_notification;



@end



















