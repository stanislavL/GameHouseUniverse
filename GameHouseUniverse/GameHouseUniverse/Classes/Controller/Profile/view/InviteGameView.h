//
//  InviteGameView.h
//  GameHouseUniverse
//
//  Created by stanislav on 17/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUDialogView.h"
#import "ProfileMenuViewController.h"
#import "ProfileEditViewController.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"


@class ProfileDetailsViewController;

@interface InviteGameView : UIViewController {
    
    IBOutlet UIButton* inviteBtn;
    IBOutlet UIButton* friendsBtn;
    IBOutlet UIButton* communitiesBtn;
    IBOutlet UIButton* backBtn;
    IBOutlet UIImageView* gameImage;
    
    AppDelegate* appDelegate;
    
    
    
}

@property (nonatomic, retain) GHUDialogView* pop;
@property (nonatomic, retain) UIViewController* superViewController;


- (IBAction)didPressInviteBtn:(id)sender;
- (IBAction)didPressFriendsBtn:(id)sender;
- (IBAction)didPressCommunitesBtn:(id)sender;
- (IBAction)didPressBackBtn:(id)sender;

@end
