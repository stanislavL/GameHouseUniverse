//
//  CommunitiesViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileMenuViewController.h"
#import "FeedViewController.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUTextView.h"
#import "GHUCommunity.h"
#import "GHUDataManager.h"
#import "GHUScreenManager.h"
#import "GHUSessionManager.h"
#import "GHUApiRequest.h"
#import "GHUAPNSManager.h"
#import "StartCommunitiesViewController.h"
#import "EditCommunitiesViewController.h"
#import "EditCommunitesLinkView.h"
#import "CommunityTableViewCell.h"
#import "AppDelegate.h"

@class ProfileMenuViewController;
@class GHUDialogView;

@interface CommunitiesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UIButton* menuBtn;
    IBOutlet UIButton* messageBtn;
    IBOutlet UIButton* searchBtn;
    IBOutlet UIButton* lunchBtn;
    IBOutlet UIButton* filterBtn;
    
    IBOutlet GHUTextField* searchCommunity;
    IBOutlet UITableView* contentTable;
    IBOutlet GHULabel* badgeLabel;
    
    AppDelegate* appDelegate;
    
    ProfileMenuViewController* menuView;
    GHUDialogView* dialog;
    BOOL showMenu;
    
}
@property (nonatomic, strong) IBOutlet UIView* contentView;
@property (nonatomic, retain) IBOutlet UITableView* contentTable;
@property (nonatomic, retain) IBOutlet GHUTextField* searchCommunity;
@property (nonatomic, retain) IBOutlet GHULabel* badgeLabel;

- (void) setUpElement;
- (void) updateElement;

- (IBAction)didPressMenuBtn:(id)sender;
- (IBAction)didPressMessageBtn:(id)sender;
- (IBAction)didPressSearchBtn:(id)sender;
- (IBAction)didPressLaunchBtn:(id)sender;
- (IBAction)didPressFilterBtn:(id)sender;

@end
