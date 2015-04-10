//
//  SeacrhResultView.h
//  GameHouseUniverse
//
//  Created by stanislav on 31/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsViewController.h"
#import "AppDelegate.h"
#import "GHUTextField.h"
#import "GHULabel.h"
#import "GHUTextView.h"

@interface SeacrhResultView : UIView <UITableViewDelegate, UITableViewDataSource> {
    
    GHUTextField* searchItem;
    UITableView* resultView;
    GHULabel* titleLabel;
    
}
- (void) setUpElement;
- (void) updateElement;
- (void) initWithSearchResultView;
@end











