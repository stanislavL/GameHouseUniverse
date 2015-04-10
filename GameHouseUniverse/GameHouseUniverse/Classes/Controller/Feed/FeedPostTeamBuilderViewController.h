//
//  FeedPostTeamBuilderViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 06/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "feedViewCell.h"
#import "FeedViewController.h"
#import "FeedTools.h"
#import "FeedDetailsViewController.h"
#import "GHUTextField.h"
#import "GHUTextView.h"
#import "GHULabel.h"
#import "GHUSessionManager.h"

#import "AppDelegate.h"

@interface FeedPostTeamBuilderViewController : UIViewController{
    
    
    IBOutlet GHULabel* teamName;
    IBOutlet GHULabel* communitiesName;
    
    IBOutlet GHUTextView* communiteDescription;
    IBOutlet GHUTextView* teamDescription;
    
    
    IBOutlet UIButton* cancelBtn;
    IBOutlet UIButton* postTeamBuilderBtn;
    
    IBOutlet UIButton* deleteTeamBuilder;
    IBOutlet UIButton* LunchTeamBuilder;
}

@property (nonatomic, retain) IBOutlet GHULabel* teamName;
@property (nonatomic, retain) IBOutlet GHULabel* communitiesName;
@property (nonatomic, retain) IBOutlet GHUTextView* communiteDescription;
@property (nonatomic, retain) IBOutlet GHUTextView* teamDescription;

- (void) setUpElement;
- (void) updateElement;

- (IBAction)didPressCancelBtn:(id)sender;
- (IBAction)didPressPostBtn:(id)sender;
- (IBAction)didPressDeleteBtn:(id)sender;
- (IBAction)didPressLunchBtn:(id)sender;

@end
