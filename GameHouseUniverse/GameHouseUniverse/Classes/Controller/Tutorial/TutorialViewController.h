//
//  TutorialViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUSwipeView.h"
#import "ProfileMenuViewController.h"
#import "SignUpViewController.h"
#import "StartViewController.h"
#import "WelcomeViewController.h"
#import "GHUGameIDs.h"
#import "GHUUserInfo.h"
#define tutorialPageCount     5;

@interface TutorialViewController : UIViewController{
    

}
@property (nonatomic,copy) GHUGameIDs* gameIDs;
@property (nonatomic,copy) GHUUserInfo* userInfo;

@end
