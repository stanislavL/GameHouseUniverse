//
//  FriendsInvitationPopUpView.m
//  GameHouseUniverse
//
//  Created by stanislav on 31/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "FriendsInvitationPopUpView.h"


@implementation FriendsInvitationPopUpView
@synthesize gameObjectFiled;
@synthesize searchFiled;
@synthesize aryFriends;
@synthesize invitedListTable;
@synthesize selectedScrollView;

- (void) dealloc{
    
    self.gameObjectFiled = nil;
    self.searchFiled = nil;
    self.aryFriends = nil;
    self.invitedListTable = nil;
    self.selectedScrollView = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//===============================================================================================================
#pragma mark -
#pragma mark - InitWithView data SetUp
//===============================================================================================================
- (void) popUpWithInvitView:(NSMutableArray*)_aryImage _item:(GHUGameIDs*) _item{
    
    
    
}
- (void) initWithData{
    
    
}
//===============================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//===============================================================================================================
- (void) setUpElement{
    
    
    
}

- (void) updateElement{
    

}
//===============================================================================================================
#pragma mark -
#pragma mark - TableView delegate and Data Source
//===============================================================================================================

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return -1;
}
- (NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return nil;
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return -1;
}


@end
