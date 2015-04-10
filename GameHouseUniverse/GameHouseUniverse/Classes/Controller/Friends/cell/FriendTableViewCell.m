//
//  FriendTableViewCell.m
//  GameHouseUniverse
//
//  Created by stanislav on 31/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "FriendTableViewCell.h"

@implementation FriendTableViewCell
@synthesize friendName;
@synthesize friendPicture;

//===============================================================================================================
#pragma mark -
#pragma mark - dealloc Method
//===============================================================================================================
- (void) dealloc{
    
    self.friendName = nil;
    self.friendPicture = nil;
    [super dealloc];
    
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Initialization code
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


}
//===============================================================================================================
#pragma mark -
#pragma mark - FriendCell Data SetUp
//===============================================================================================================
- (void) populateItem:(GHUGameIDs *)_item{
    
    self.friendName.text = [_item formatContactFullNameReadable];
    self.friendPicture.image = [_item formatProfilePicture];
    
}

@end
