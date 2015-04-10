//
//  FeedViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "ProfileMenuViewController.h"
#import "ProfileDetailsViewController.h"
#import "AppDelegate.h"
#import "GHUGameIDs.h"
#import "GHUUserInfo.h"
#import "GHUDataManager.h"
#import "GHUViewController.h"
#import "FeedTools.h"

#import "AppDelegate.h"

@class PostView;
@class GHUDialogView;
@class ProfileMenuViewController;

@interface FeedViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    

    IBOutlet UIButton* searchButton;
    IBOutlet UIButton* postButton;
    IBOutlet UIButton* teamButton;

    
    GHUViewController* activeViewController;
    IBOutlet UITableView* feedTable;
    
    GHUGameIDs* gameIds;
    AppDelegate* appDelegate;
    ProfileMenuViewController* menuView;
    GHUDialogView* dialog;
    PostView* postView;

    BOOL showMenu;
    
}

@property (nonatomic, retain) GHUViewController* activeViewController;
@property (nonatomic, retain) GHUGameIDs* gameIds;
@property (nonatomic, retain) NSMutableArray* aryBtn;
@property (nonatomic, retain) PostView* postView;
@property (nonatomic, retain) IBOutlet UIView* contentView;
@property (nonatomic, retain) IBOutlet UITableView* feedTable;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segment;

- (void) openWithVC:(GHUGameIDs*) gameID;
- (void) setUpElement;
- (void) updateElement;
- (void) showPostView:(BOOL) show;


- (IBAction) didPressSearchBtn:(id)sender;
- (IBAction) didPressMenuBtn:(id)sender;
- (IBAction) didPressPostBtn:(id)sender;
- (IBAction) didPressTeamBtn:(id)sender;

@end


