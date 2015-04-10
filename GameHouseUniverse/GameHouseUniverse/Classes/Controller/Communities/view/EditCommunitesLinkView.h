//
//  EditCommunitesLinkView.h
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHULabel.h"
#import "GHUTextView.h"
#import "GHUTextField.h"
#import "GHUCommunity.h"
#import "GHUDataManager.h"
#import "GHUDialogView.h"
#import "GHUScreenManager.h"
#import "GHUSessionManager.h"

@class EditCommunitiesViewController;
@interface EditCommunitesLinkView : UIViewController{

    IBOutlet UIButton* updateLinkBtn;
    IBOutlet UIButton* addNewLinkBtn;
    
    IBOutlet GHUTextField* twitch;
    IBOutlet GHUTextField* facebook;
    IBOutlet GHUTextField* website;
    IBOutlet GHUTextField* meetup;
    IBOutlet GHUTextField* email;
    
    GHUDialogView* pop;
    EditCommunitiesViewController* editCommunities;
}
@property (nonatomic, retain) GHUDialogView* pop;
@property (nonatomic, retain) EditCommunitiesViewController* editCommunities;
@property (nonatomic, retain) IBOutlet GHUTextField* twitch;
@property (nonatomic, retain) IBOutlet GHUTextField* facebook;
@property (nonatomic, retain) IBOutlet GHUTextField* website;
@property (nonatomic, retain) IBOutlet GHUTextField* meetup;
@property (nonatomic, retain) IBOutlet GHUTextField* email;

- (IBAction)didPresseUpdateBtn:(id)sender;
- (IBAction)didPresseAddBtn:(id)sender;
@end
