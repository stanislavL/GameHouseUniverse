//
//  CommunityTableViewCell.h
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUTextView.h"
#import "GHUViewController.h"
#import "GHUCommunity.h"
@interface CommunityTableViewCell : UITableViewCell{
    
    IBOutlet GHULabel* communityName;
    IBOutlet GHULabel* communityDescription;
    IBOutlet GHULabel* communityMembers;
    IBOutlet GHULabel* communitySubScribers;
    IBOutlet UIImageView* communityImage;
    
    
}
@property (nonatomic, retain) IBOutlet GHULabel* communityName;
@property (nonatomic, retain) IBOutlet GHULabel* communityDescription;
@property (nonatomic, retain) IBOutlet GHULabel* communityMembers;
@property (nonatomic, retain) IBOutlet GHULabel* communitySubScribers;
@property (nonatomic, retain) IBOutlet UIImageView* communityImage;

- (void) populateItem:(GHUCommunity*)_item;
@end
