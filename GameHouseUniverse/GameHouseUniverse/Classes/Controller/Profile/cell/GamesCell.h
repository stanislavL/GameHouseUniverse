//
//  GamesCell.h
//  GameHouseUniverse
//
//  Created by stanislav on 16/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUDataManager.h"
#import "GHUTable.h"



@class ProfileEditViewController;
@class AddGameViewController;
@interface GamesCell : UITableViewCell{
    
    IBOutlet UIImageView* iconImage;
    IBOutlet GHULabel* label;

    
    
}
@property (nonatomic, assign) NSInteger rowID;
@property (nonatomic, assign) NSInteger columID;
@property (nonatomic, retain)  ProfileEditViewController* parentController;
@property (nonatomic, retain)  AddGameViewController* addViewController;
@property (nonatomic, strong)  IBOutlet UIImageView* iconImage;
@property (nonatomic, strong)  IBOutlet GHULabel* label;
@property (nonatomic, strong)  IBOutlet UIButton* addButton;
@property (nonatomic, strong)  IBOutlet UIButton* deleteButton;

- (void) populateItem:(NSString*) tagId  gameTitle:(NSString*) gameTitle iconStr:(NSString*) iconStr  rowId:(NSInteger) rowId colId:(NSInteger) colId add:(BOOL) add;
@end
