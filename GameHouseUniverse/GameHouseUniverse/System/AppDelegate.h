//
//  AppDelegate.h
//  GameHouseUniverse
//
//  Created by stanislav on 13/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GAI.h"

extern float fx;
extern float fy;
extern CGSize winSize;
extern float buttonsPosition[10][2];
extern float btnPos[10][2];
extern NSString *const sessionStateChangeNotification;
extern BOOL enableProfile;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    IBOutlet UINavigationController* viewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet UINavigationController* viewController;
@property (strong, nonatomic) FBSession* session;



- (NSString*) getDeviceString:(NSString*) vcName;


@end
