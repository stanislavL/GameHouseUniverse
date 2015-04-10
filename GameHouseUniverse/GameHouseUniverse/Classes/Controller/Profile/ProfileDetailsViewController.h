//
//  ProfileMenuViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProfileEditViewController.h"
#import "GHUGameIDs.h"
#import "GHUUserInfo.h"
#import "GHUDataManager.h"
#import "GHUGame.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUScrollView.h"
#import "GHUGamesView.h"
#import "AppDelegate.h"


@class TagPopView;
@class ProfileMenuViewController;
@class GHUDialogView;

@interface ProfileDetailsViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>{
    
    GHUGameIDs* contact;
 
    
    TagPopView* _popView;
    
    AppDelegate* appDelegate;

    ProfileMenuViewController* menuView;
    GHUDialogView* dialog;
    BOOL showMenu;
    BOOL showRecent;
    BOOL showCommunity;
    BOOL showFriend;
    BOOL showRows;



}
@property (nonatomic, retain) GHUGameIDs* contact;
@property (nonatomic, copy)   GHUUserInfo* userInfo;

@property (nonatomic, retain) NSMutableArray* aryGameIdBtn;
@property (nonatomic, retain) NSMutableArray* aryGameIdList;
@property (nonatomic, retain) NSMutableArray* aryGames;
@property (nonatomic, retain) NSMutableArray* aryCommunities;
@property (nonatomic, retain) NSMutableArray* aryFriends;


@property (nonatomic, retain) NSMutableArray* aryRows;

@property (nonatomic, strong) IBOutlet UITableView* listTableView;
@property (nonatomic, strong) IBOutlet UIButton* menuButton;
@property (nonatomic, strong) IBOutlet UIButton* searchButton;
@property (nonatomic, strong) IBOutlet UIButton* messageButton;
@property (nonatomic, strong) IBOutlet UIButton* settingsButton;
@property (nonatomic, strong) IBOutlet UIImageView* profileImage;

@property (nonatomic, retain) TagPopView* popView;

@property (nonatomic, strong) IBOutlet UIView* contentView;
@property (nonatomic, strong) IBOutlet GHULabel* username;
@property (nonatomic, strong) IBOutlet GHULabel* memberDate;


- (void) setUpElement;
- (void) updateElement;
- (void) showInvteGamedialog;

- (IBAction)didPressSearchBtn:(id)sender;
- (IBAction)didPressMenuBtn:(id)sender;
- (IBAction)didPressMessageBtn:(id)sender;
- (IBAction)didPressSettingsBtn:(id)sender;
- (IBAction)didPressInviteBtn:(id)sender;


@end
