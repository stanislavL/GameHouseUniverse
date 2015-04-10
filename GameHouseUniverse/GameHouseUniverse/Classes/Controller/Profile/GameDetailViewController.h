//
//  GameDetailViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 24/01/15.
//  Copyright (c) 2015 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDetailsViewController.h"
#import "ProfileEditViewController.h"
#import "ProfileMenuViewController.h"
#import "GHULabel.h"
#import "GHUGamesView.h"
#import "GHUTextField.h"
#import "AppDelegate.h"


@class ProfileMenuViewController;
@class GHUDialogView;

@interface GameDetailViewController : UIViewController{
    
    AppDelegate* appDelegate;

    ProfileMenuViewController* menuView;
    GHUDialogView* dialog;

    BOOL showMenu;
    BOOL enableGameList;
    BOOL showRecent;
    BOOL showCommunity;
    BOOL showFriend;
    BOOL showRows;
}


@property (nonatomic, retain) NSMutableArray* arySubGameBtn;
@property (nonatomic, retain) NSMutableArray* arySubGameList;
@property (nonatomic, strong) NSMutableArray* aryRecentGame;
@property (nonatomic, strong) NSMutableArray* aryCommunities;
@property (nonatomic, strong) NSMutableArray* aryFriends;


@property (nonatomic, retain) GHUUserInfo* userInfo;
@property (nonatomic, retain) UIImage*     gameIdName;
@property (nonatomic, retain) NSString*    GametagName;


@property (nonatomic, strong) IBOutlet UIView* contentView;
@property (nonatomic, strong) IBOutlet UIView* beforeView;
@property (nonatomic, strong) IBOutlet UITableView* listTableView;

@property (nonatomic, strong) IBOutlet GHULabel* userName;
@property (nonatomic, strong) IBOutlet GHULabel* memberDate;

//-------------------------------------- First This labels should be show --------------------------------------
@property (nonatomic, strong) IBOutlet GHULabel* addGameLabel;
@property (nonatomic, strong) IBOutlet UIButton* addGameButton;

@property (nonatomic, strong) IBOutlet UIButton* idsButton;
@property (nonatomic, strong) IBOutlet UIButton* inviteGameBtn;


- (void) openWithVC:(UIImage*) idsName tagName:(NSString*) tagName;
- (void) setUpElement;
- (void) loadData;

@end
