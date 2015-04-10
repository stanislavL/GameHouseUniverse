//
//  FriendsInvitationPopUpView.h
//  GameHouseUniverse
//
//  Created by stanislav on 31/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsViewController.h"
#import "GHUTextField.h"
#import "GHULabel.h"
#import "GHUGameIDs.h"

@interface FriendsInvitationPopUpView : UIView<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>{
    
    UIScrollView* selectedScrollView;
    UITableView* invitedListTable;
    UIImageView* backImage;
    
    GHULabel* tabletitle;
    GHULabel* selfTitlel;
    
    GHUTextField* gameObjectFiled;
    GHUTextField* searchFiled;
    
    NSMutableArray* aryFriends;
    
}
@property (nonatomic, retain) NSMutableArray* aryFriends;
@property (nonatomic, retain) GHUTextField* gameObjectFiled;
@property (nonatomic, retain) GHUTextField* searchFiled;
@property (nonatomic, retain) UITableView* invitedListTable;
@property (nonatomic, retain) UIScrollView* selectedScrollView;

- (void) popUpWithInvitView:(NSMutableArray*)_aryImage _item:(GHUGameIDs*) _item;
- (void) initWithData;
- (void) setUpElement;
- (void) updateElement;
@end
