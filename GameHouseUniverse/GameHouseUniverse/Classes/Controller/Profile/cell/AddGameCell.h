//
//  AddGameCell.h
//  GameHouseUniverse
//
//  Created by Admin on 2/7/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GHULabel.h"

@class ProfileEditViewController;
@interface AddGameCell : UITableViewCell{
    
    
}
@property(nonatomic, assign) NSIndexPath* indexPath;
@property(nonatomic, strong) IBOutlet GHULabel* addGameLabel;
@property(nonatomic, retain) ProfileEditViewController* profile;

- (void) popularItem:(NSString*) title index:(NSIndexPath*) index;

@end
