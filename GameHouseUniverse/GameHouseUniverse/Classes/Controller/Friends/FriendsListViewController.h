//
//  FriendsListViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 13/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsViewController.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUTable.h"
#import "FriendsInvitationPopUpView.h"

@interface FriendsListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>{
    
    IBOutlet UIButton* menuBtn;
    IBOutlet UIButton* messageBtn;
    IBOutlet UIButton* searchBtn;
    IBOutlet UIButton* inviteBtn;

    IBOutlet UITableView* contentTable;
    IBOutlet UIButton* filterBtn;
    
    IBOutlet UISearchBar* mainTagSearch;
    
    NSString* strMessage;
    NSString* strRequest;
    
    
    
}
@property (nonatomic, retain) IBOutlet UITableView* contentTable;
@property (nonatomic, strong) IBOutlet UISearchBar* mainTagSearch;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segment;
@property (nonatomic, retain) NSString* strMessage;
@property (nonatomic, retain) NSString* strRequest;

- (void) setUpElement;
- (void) updateElement;
- (void) openWithVC;

- (IBAction)didPressMenuBtn:(id)sender;
- (IBAction)didPressMessageBtn:(id)sender;
- (IBAction)didPressSearchBtn:(id)sender;
- (IBAction)didPressInviteBtn:(id)sender;
- (IBAction)didPressFilterBtn:(id)sender;
@end
