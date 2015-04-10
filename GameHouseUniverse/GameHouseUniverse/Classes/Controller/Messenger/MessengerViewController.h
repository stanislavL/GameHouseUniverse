//
//  MessengerViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "GHUApiRequest.h"
#import "GHUAPNSManager.h"
#import "GHUAlertView.h"
#import "GHUDataManager.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUTextView.h"
#import "GHUUserInfo.h"
#import "GHUViewController.h"
#import "MessengerTableViewCell.h"

@interface MessengerViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    UITableView* contentTableView;
    IBOutlet UIButton* backButton;
    IBOutlet UIButton* feedButton;
    IBOutlet UIButton* activeButton;
    IBOutlet UIButton* archiveButton;
    IBOutlet UIButton* searchButton;
    IBOutlet UIButton* newGameButton;
    
    GHULabel* feedlabel;
    GHULabel* activelabel;
    
    GHUViewController* activeViewController;
    
    
    
}
@property (nonatomic, retain) GHULabel* feedlabel;
@property (nonatomic, retain) GHULabel* activelabel;
@property (nonatomic, retain) GHUViewController* activeViewController;

- (void) openWithVC:(GHUUserInfo*) userInfo;
- (void) setupElement;
- (void) updateElement;
- (void) saveData;

- (IBAction)didPressBackBtn:(id)sender;
- (IBAction)didPressSearchBtn:(id)sender;
- (IBAction)didPressFeedBtn:(id)sender;
- (IBAction)didPressActiveBtn:(id)sender;
- (IBAction)didPressArchiveBtn:(id)sender;
- (IBAction)didPressNewGameBtn:(id)sender;

@end
