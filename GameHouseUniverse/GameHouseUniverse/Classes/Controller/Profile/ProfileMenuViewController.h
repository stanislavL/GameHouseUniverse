//
//  ProfileViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileEditViewController.h"
#import "ProfileViewController.h"
#import "GHUDataManager.h"
#import "GHUApiRequest.h"
#import "GHUGameIDs.h"
#import "GHUGame.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUAPNSManager.h"
#import "GHUAlertView.h"
#import "AppDelegate.h"
#import "GHUDialogView.h"
#import "GHUUserInfo.h"

@interface ProfileMenuViewController : UIViewController{
    
    IBOutlet UIButton* viewProfileButton;
    IBOutlet UIButton* editProfileButton;

    
    IBOutlet UIButton* friendButton;
    IBOutlet UIButton* currentGameButton;

    
    AppDelegate* appDelegate;
    
    
    
}

@property (nonatomic, retain) UIViewController* superViewController;

@property (nonatomic, retain) IBOutlet GHULabel* userName;
@property (nonatomic, retain) IBOutlet GHULabel* userMemberSince;
@property (nonatomic, strong) IBOutlet UIImageView* profileImage;
@property (nonatomic, retain) GHUDialogView* pop;
@property (nonatomic, retain) GHUUserInfo* userInfo;



- (void) setUpElement;
- (IBAction) didPressViewProfileBtn:(id)sender;
- (IBAction) didPressEditProfileBtn:(id)sender;

- (IBAction) didPressTeamBuilderBtn:(id)sender;
- (IBAction) didPressFriendBtn:(id)sender;
- (IBAction) didPressCommunitiesBtn:(id)sender;
- (IBAction) didPressLogoutBtn:(id)sender;



@end
