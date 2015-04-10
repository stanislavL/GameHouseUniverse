//
//  FeedDetailsViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 30/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "feedViewCell.h"
#import "FeedTools.h"
#import "GHUGameIDs.h"
#import "GHUScreenManager.h"
#import "GHUTextView.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "AppDelegate.h"

@interface FeedDetailsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UIButton* menuBtn;
    IBOutlet UIButton* messageBtn;
    IBOutlet UIButton* searchBtn;
    IBOutlet UIButton* cancelPostBtn;
    IBOutlet UIButton* postBtn;
    
    IBOutlet UIButton* deletePostBtn;
    IBOutlet UITableView* contentTable;
}
@property (nonatomic, retain) IBOutlet UITableView* contentTable;

- (void) setUpElement;
- (void) updateElement;

- (IBAction)didPressMenuBtn:(id)sender;
- (IBAction)didPressMessageBtn:(id)sender;
- (IBAction)didPressSearchBtn:(id)sender;
- (IBAction)didPressCancelPostBtn:(id)sender;
- (IBAction)didPresPostBtn:(id)sender;
- (IBAction)didPressDeletePostBtn:(id)sender;
@end
