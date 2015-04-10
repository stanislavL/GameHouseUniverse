//
//  MessengerTableViewCell.h
//  GameHouseUniverse
//
//  Created by stanislav on 31/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GHULabel.h"
#import "GHUTextView.h"
#import "GHUGameIDs.h"
#import "GHUUserInfo.h"
#import "GHUDataManager.h"
#import "GHUTable.h"
#import "MessengerViewController.h"

@interface MessengerTableViewCell : UITableViewCell{
    
    IBOutlet GHULabel* userName;
    IBOutlet GHULabel* gameID;
    IBOutlet GHULabel* gameName;
    IBOutlet GHULabel* description;
    IBOutlet GHULabel* expandCount;
    
    IBOutlet UIImageView* profilePicture;
    IBOutlet UIImageView* gameIcon;
    IBOutlet UIButton* chatButton;
    
}

@property (nonatomic, retain) GHULabel* userName;
@property (nonatomic, retain) GHULabel* gameID;
@property (nonatomic, retain) GHULabel* gameName;
@property (nonatomic, retain) GHULabel* description;
@property (nonatomic, retain) GHULabel* expandCount;
@property (nonatomic, retain) UIImageView* profilePicture;
@property (nonatomic, retain) UIImageView* gameIcon;

- (void) populateItem:(GHUGameIDs*) item;
- (IBAction)didPressChartBtn:(id)sender;
- (IBAction)didPressHelpBtn:(id)sender;

@end




