//
//  StartCommunitiesViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUTextView.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUDialogView.h"
#import "GHUCommunity.h"
#import "GHUDataManager.h"
#import "GHUSessionManager.h"
#import "GHUApiRequest.h"
#import "CommunitiesViewController.h"
#import "EditCommunitesLinkView.h"
#import "EditCommunitiesViewController.h"
#import "DetailCommunitiesViewController.h"
#import "AppDelegate.h"

@interface StartCommunitiesViewController : UIViewController{
    
    IBOutlet UIButton* menuBtn;
    IBOutlet GHUTextField* name;
    IBOutlet GHUTextField* game;
    IBOutlet GHUTextField* city;
    
    IBOutlet UIImageView* myImage;
    IBOutlet GHUTextField* searchFriends;
    
    AppDelegate* appDelegate;
}

@property (nonatomic, retain) IBOutlet GHUTextField* name;
@property (nonatomic, retain) IBOutlet GHUTextField* game;
@property (nonatomic, retain) IBOutlet GHUTextField* city;
@property (nonatomic, retain) IBOutlet UIImageView* myImage;
@property (nonatomic, retain) IBOutlet GHUTextField* searchFriends;

- (void) openWithVC:(NSString*) profileImage;
- (void) setUpElement;
- (void) updateElement;
- (IBAction) didPressMenuBtn:(id)sender;

@end
