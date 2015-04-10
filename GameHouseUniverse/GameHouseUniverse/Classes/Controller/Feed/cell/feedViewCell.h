//
//  feedViewCell.h
//  GameHouseUniverse
//
//  Created by stanislav on 30/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHULabel.h"
#include "GHUTextView.h"

@interface feedViewCell : UITableViewCell{
    
    IBOutlet UIImageView* image;
    IBOutlet GHUTextView* contentLabel;
    IBOutlet GHULabel* title;
    IBOutlet UIButton* likeButton;
    IBOutlet UIButton* chatButton;
    
    NSString* contentStr;
    NSString* titleStr;
    NSString* timeStr;
    NSDate* dateInfo;
    
    
}

@property (nonatomic, retain) NSString* contentStr;
@property (nonatomic, retain) NSString* titleStr;
@property (nonatomic, retain) NSString* timeStr;
@property (nonatomic, retain) NSDate* dateInfo;

- (IBAction)didPresslikeBtn:(id)sender;
- (IBAction)didPresschatBtn:(id)sender;
- (void) populateItem:(NSString*) username  gamerID:(NSString*) gamerID gameName:(NSString*) gameName contentStr:(NSString*) contentStr columnId:(NSInteger) columnId rowId:(NSInteger) rowId;

@end
