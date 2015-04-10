//
//  FriendsViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHULabel.h"
#import "GHUTextView.h"
#import "GHUTable.h"
#import "GHUUserInfo.h"
#import "AppDelegate.h"

@class ProfileMenuViewController;
@class GHUDialogView;
@interface FriendsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>{
    

    IBOutlet UIButton* searchButton;
    IBOutlet UIButton* menuButton;

    IBOutlet UIButton* gameFilterButton;
    IBOutlet UIButton* contactEmailButton;
    IBOutlet UISearchBar* mainTagSearch;
    IBOutlet UISearchBar* gameFilterSearch;
    
    IBOutlet UITableView* contentTable;
    
    ProfileMenuViewController* menuView;
    GHUDialogView* dialog;
    AppDelegate* appDelegate;
    BOOL showMenu;
    
}
@property (nonatomic, strong) IBOutlet UIView* contentView;
@property (nonatomic, strong) IBOutlet UISearchBar* mainTagSearch;
@property (nonatomic, strong) IBOutlet UISearchBar* gameFilterSearch;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segment;

- (void) setUpElement;
- (void) updateElement;
- (void) saveData;


- (IBAction)didPressSearchBtn:(id)sender;
- (IBAction)didPressMenuBtn:(id)sender;
- (IBAction)didPressFilterBtn:(id)sender;
- (IBAction)didPressContactBtn:(id)sender;
@end
