//
//  FriendTableViewCell.h
//  GameHouseUniverse
//
//  Created by stanislav on 31/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsViewController.h"
#import "FriendsListViewController.h"
#import "FriendsInvitationPopUpView.h"
#import "AppDelegate.h"
#import "GHULabel.h"
#import "GHUTextView.h"
#import "GHUGameIDs.h"

@interface FriendTableViewCell : UITableViewCell{
    
    IBOutlet GHULabel* friendName;
    IBOutlet UIImageView* friendPicture;
    
    
}
@property (nonatomic, retain) GHULabel* friendName;
@property (nonatomic, retain) UIImageView* friendPicture;

- (void) populateItem:(GHUGameIDs*) item;

@end
