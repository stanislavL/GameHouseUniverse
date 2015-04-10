//
//  DetailCommunitiesViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunitiesViewController.h"
#import "EditCommunitesLinkView.h"
#import "EditCommunitiesViewController.h"
#import "StartCommunitiesViewController.h"
#import "GHUTextView.h"
#import "GHULabel.h"
#import "GHUSessionManager.h"
#import "GHUTextField.h"
#import "GHUCommunity.h"
#import "AppDelegate.h"

@interface DetailCommunitiesViewController : UIViewController {
    
    IBOutlet UIButton* menuBtn;
    IBOutlet UIButton* messageBtn;
    IBOutlet UIButton* searchBtn;
    IBOutlet UIButton* settingsBtn;

    IBOutlet UIButton* joinBtn;
    IBOutlet UIButton* subscribeBtn;
    
    IBOutlet GHULabel* messageBadgeLabel;
    IBOutlet GHULabel* postBadgeLabel;
    
    IBOutlet GHULabel* communityName;
    IBOutlet GHULabel* communityDescription;
    IBOutlet GHULabel* communityMembers;
    IBOutlet GHULabel* communitySubScribers;
    
    
    NSMutableArray* aryLinks;
    NSString* postCount;
    NSString* badgeCount;
    
    GHUCommunity* community;
    AppDelegate* appDelegate;
}

@property (nonatomic, retain) GHUCommunity* community;
@property (nonatomic, retain) IBOutlet GHULabel* messageBadgeLabel;
@property (nonatomic, retain) IBOutlet GHULabel* postBadgeLabel;

@property (nonatomic, strong) IBOutlet GHULabel* communityName;
@property (nonatomic, strong) IBOutlet GHULabel* communityDescription;
@property (nonatomic, strong) IBOutlet GHULabel* communityMembers;
@property (nonatomic, strong) IBOutlet GHULabel* communitySubScribers;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segment;

@property (nonatomic, retain) NSMutableArray* aryLinks;
@property (nonatomic, retain) NSString* postCount;
@property (nonatomic, retain) NSString* badgeCount;

- (void) openWithVC:(GHUCommunity*) item;
- (void) setUpElement;
- (void) updateElement;

- (IBAction) didPressedMenuBtn:(id)sender;
- (IBAction) didPressedMessageBtn:(id)sender;
- (IBAction) didPressedSearchBtn:(id)sender;
- (IBAction) didPressedSettingsBtn:(id)sender;
- (IBAction) didPressedJoinBtn:(id)sender;
- (IBAction) didPressedSubscribeBtn:(id)sender;

@end
