//
//  feedViewCell.m
//  GameHouseUniverse
//
//  Created by stanislav on 30/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "feedViewCell.h"

@implementation feedViewCell

@synthesize contentStr;
@synthesize titleStr;
@synthesize dateInfo;
@synthesize  timeStr;


//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (void) dealloc{
    
    self.contentStr = nil;
    self.titleStr = nil;
    self.dateInfo = nil;

    [super dealloc];
}
//===============================================================================================================
#pragma mark -
#pragma mark - initialized Method
//===============================================================================================================
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

 
}
//===============================================================================================================
#pragma mark -
#pragma mark - Self Setup in Parent TableView
//===============================================================================================================
- (void) populateItem:(NSString*) username  gamerID:(NSString*) gamerID gameName:(NSString*) gameName contentStr:(NSString*) contentStr columnId:(NSInteger) columnId rowId:(NSInteger) rowId{
    
    
}

//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction)didPresslikeBtn:(id)sender{
    
    NSLog(@"LikeButton Pressed");

}
- (IBAction)didPresschatBtn:(id)sender{
    
    NSLog(@"ChatButton Pressed");
    

}

@end
