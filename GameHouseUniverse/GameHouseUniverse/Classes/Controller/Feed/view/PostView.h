//
//  PostView.h
//  GameHouseUniverse
//
//  Created by stanislav on 02/12/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUTextField.h"
#import "GHULabel.h"
#import "GHUTextView.h"
#import "GHUAlertView.h"
#import "FeedViewController.h"
#import "FeedDetailsViewController.h"
#import "FeedPostTeamBuilderViewController.h"
#import "AppDelegate.h"

@interface PostView : UIView{
    
    IBOutlet UIButton* cancelBtn;
    IBOutlet UIButton* createBtn;

    UIAlertView* alertSignIn;
    FeedViewController* feed;
}
@property (nonatomic, retain) IBOutlet GHUTextField* teamName;
@property (nonatomic, retain) IBOutlet GHUTextField* communitiesName;
@property (nonatomic, retain) UIAlertView* alertSignIn;
@property (nonatomic, retain) FeedViewController* feed;

+ (id) postView;
- (BOOL) validateInput;
- (void) setUpElement;
- (void) updateElement;
@end
