//
//  EditCommunitiesViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUTable.h"
#import "GHUTextField.h"
#import "GHUTextView.h"
#import "GHUDialogView.h"
#import "GHUDataManager.h"
#import "GHUCommunity.h"
#import "GHUSessionManager.h"
#import "GHUApiRequest.h"
#import "CommunityTableViewCell.h"
#import "CommunitiesViewController.h"
#import "DetailCommunitiesViewController.h"
#import "StartCommunitiesViewController.h"
#import "EditCommunitesLinkView.h"
#import "AppDelegate.h"

@interface EditCommunitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UIButton* menuBtn;
    IBOutlet UIButton* messageBtn;
    IBOutlet UIButton* searchBtn;
    IBOutlet UIButton* settingsBtn;
    IBOutlet UIButton* founderBtn;
    
    IBOutlet GHULabel* communityName;
    IBOutlet GHUTextField* searchCommunities;
    IBOutlet UITableView* contentTable;

    
}
@property (nonatomic, retain) IBOutlet GHULabel* communityName;
@property (nonatomic, retain) IBOutlet GHUTextField* searchCommunities;
@property (nonatomic, retain) IBOutlet UITableView* contentTable;

- (void) setUpElement;
- (void) updateElement;

- (IBAction)didPressMenuBtn:(id)sender;
- (IBAction)didPressMessageBtn:(id)sender;
- (IBAction)didPressSearchBtn:(id)sender;
- (IBAction)didPressSettingsBtn:(id)sender;
- (IBAction)didPressFounderBtn:(id)sender;
@end
