//
//  FeedTools.h
//  GameHouseUniverse
//
//  Created by stanislav on 30/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "FeedDetailsViewController.h"

#import "GHULabel.h"
#import "GHUTextView.h"
#import "GHUBarButtonItem.h"

@interface FeedTools : UIView {
    
    UIButton* postButton;
    UIButton* teamBuilderButton;
    UILabel* postLabel;
    UILabel* teamLabel;
    
}
- (void) setUpElement;
- (void) updateElement;
@end
