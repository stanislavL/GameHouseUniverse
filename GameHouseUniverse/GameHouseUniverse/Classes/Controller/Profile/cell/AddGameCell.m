//
//  AddGameCell.m
//  GameHouseUniverse
//
//  Created by Admin on 2/7/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AddGameCell.h"
#import "ProfileEditViewController.h"
@implementation AddGameCell
@synthesize addGameLabel;
@synthesize profile;
@synthesize indexPath;


- (void) dealloc{
    
    self.addGameLabel = nil;
    [super dealloc];
}
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) popularItem:(NSString*) title{
    
    self.addGameLabel.text = title;
}
- (void) popularItem:(NSString*) title index:(NSIndexPath*) index{
    
    self.indexPath = index;
    self.addGameLabel.text = title;
    
}

- (IBAction) didPressAddGameBtn:(id)sender{
    
    NSLog(@"AddGame Btn Clicked");
    [self.profile moveToAddGameView:self.indexPath];
}
@end
