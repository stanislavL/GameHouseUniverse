//
//  CommunityTableViewCell.m
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "CommunityTableViewCell.h"

@implementation CommunityTableViewCell
@synthesize communityName;
@synthesize communityDescription;
@synthesize communityMembers;
@synthesize communitySubScribers;
@synthesize communityImage;

- (void) dealloc {
    
    self.communityName = nil;
    self.communityDescription = nil;
    self.communityMembers = nil;
    self.communitySubScribers = nil;
    self.communityImage = nil;
    
    [super dealloc];
}
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
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

- (void) populateItem:(GHUCommunity*)_item{
    
    self.communityName.text = _item.name;
    self.communityDescription.text = _item.description;
    self.communityMembers.text = [NSString stringWithFormat:@"%d members" ,[_item.members intValue]];
    self.communitySubScribers.text = [NSString stringWithFormat:@"%d subscribe" ,[_item.subscribers intValue]];
    
}

@end
