//
//  MessengerTableViewCell.m
//  GameHouseUniverse
//
//  Created by stanislav on 31/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "MessengerTableViewCell.h"

@implementation MessengerTableViewCell

@synthesize userName;
@synthesize gameID;
@synthesize gameName;
@synthesize description;
@synthesize expandCount;
@synthesize profilePicture;
@synthesize gameIcon;

- (void) dealloc{
    
    self.userName = nil;
    self.gameID = nil;
    self.gameName = nil;
    self.description = nil;
    self.expandCount = nil;
    self.profilePicture = nil;
    self.gameIcon = nil;
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) populateItem:(GHUGameIDs*) item{
    
    
}

- (IBAction)didPressChartBtn:(id)sender{
    
    
}

- (IBAction)didPressHelpBtn:(id)sender{
    
    
    
}

@end
