//
//  ProfileViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 06/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUSessionManager.h"
#import "ProfileDetailsViewController.h"
#import "AppDelegate.h"
#import "ProfileEditViewController.h"
#import "GHUGameIDs.h"
#import "GHUUserInfo.h"
#import "GHUDefaultsManager.h"

@class ProfileMenuViewController;
@class GHUDialogView;

@interface ProfileViewController : UIViewController{
    
    
    UIImageView* profileImage;
    GHULabel* profileName;
    GHULabel* memberSince;
    GHULabel* feedLabel;
    

    ProfileMenuViewController* menuView;
    GHUDialogView* dialog;
    
    //********************* Tools Buttons *********************
    
    IBOutlet UIButton* menuButton;
    IBOutlet UIButton* addGameFeatureButton;
    IBOutlet UIButton* addGameComunitiesButton;
    IBOutlet UIButton* addFriendButton;
    BOOL enableGameID;
    
    NSMutableArray* aryGameIDs;
    NSMutableArray* aryGameIDsName;
    AppDelegate* appDelegate;
   
    BOOL showMenu;
    BOOL showGameIDsView;
    int idsIndex;
    
}
@property (nonatomic, strong) IBOutlet UIView* contentView;
@property (nonatomic, retain) NSMutableArray* aryGameIDs;
@property (nonatomic, retain) NSMutableArray* aryGameIDsName;
//********************* If there are any game id , it should not show.*********************
@property (nonatomic, strong) IBOutlet UIButton* addFirstGameIDButton;
@property (nonatomic, strong) IBOutlet GHULabel* addFirstGameIDLabel;


@property (nonatomic, copy) GHUGameIDs* gameIDs;
@property (nonatomic, copy) GHUUserInfo* userInfo;

@property (nonatomic, retain) IBOutlet GHULabel* profileName;
@property (nonatomic, retain) IBOutlet GHULabel* memberSince;
@property (nonatomic, retain) IBOutlet UIImageView* profileImage;
@property (nonatomic, retain) UIImage* selecteGameId;


- (void) setUpElement;
- (void) updateElement;


- (void) moveToEditView;
- (IBAction)didPresseMenuBtn:(id)sender;
- (IBAction)didPresseAddGameIDBtn:(id)sender;
- (IBAction)didPresseAddGameFeatureBtn:(id)sender;
- (IBAction)didPresseAddGameCommunitiesBtn:(id)sender;
- (IBAction)didPresseFriendBtn:(id)sender;


@end
