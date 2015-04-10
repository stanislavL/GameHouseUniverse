//
//  GamesCell.m
//  GameHouseUniverse
//
//  Created by stanislav on 16/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "GamesCell.h"
#import "ProfileEditViewController.h"
#import "AddGameViewController.h"

@implementation GamesCell
@synthesize iconImage, label, addButton, deleteButton;
@synthesize columID, rowID;
@synthesize parentController;
@synthesize addViewController;

- (void) dealloc{
    
    self.iconImage = nil;
    self.label = nil;
    self.addButton = nil;
    
    [super dealloc];
}
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.addButton.hidden = YES;
        self.addButton.userInteractionEnabled = NO;
        self.deleteButton.hidden = YES;
        self.deleteButton.userInteractionEnabled = NO;
        self.iconImage.hidden = YES;
        
    }
    return self;
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) populateItem:(NSString*) tagId  gameTitle:(NSString*) gameTitle iconStr:(NSString*) iconStr  rowId:(NSInteger) rowId colId:(NSInteger)colId add:(BOOL) add{
    
    self.columID = colId;
    self.rowID = rowId;
    
    if (add) {
        //----------if game is adding in superView
        self.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png" , iconStr]];
        self.label.text = [NSString stringWithFormat:@"%@" , gameTitle];
        self.addButton.hidden = NO;
        self.addButton.userInteractionEnabled = YES;
        self.iconImage.hidden = NO;
        
    }else{
        //----------if game is deleting in superView
        self.iconImage.hidden = YES;
        self.label.text = [NSString stringWithFormat:@"%@" , gameTitle];
        self.deleteButton.hidden = NO;
        self.deleteButton.userInteractionEnabled = YES;
    }
    

}
- (IBAction) didPressAddGameBtn:(id)sender{
    
    NSLog(@"AddCell Clicked");
    
}
- (IBAction) didPressDeleteBtn:(id)sender{

    NSLog(@"deleteCell Clicked");
    [self.parentController removeCellDataFromTable:self.rowID column:self.columID];
    [self.contentView removeFromSuperview];
    
}
@end
