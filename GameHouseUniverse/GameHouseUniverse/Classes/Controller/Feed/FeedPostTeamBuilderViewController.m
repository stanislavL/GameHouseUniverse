//
//  FeedPostTeamBuilderViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 06/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "FeedPostTeamBuilderViewController.h"

@interface FeedPostTeamBuilderViewController ()

@end

@implementation FeedPostTeamBuilderViewController
@synthesize teamDescription, teamName;
@synthesize communiteDescription, communitiesName;

- (void) dealloc{
    
    self.teamName = nil;
    self.teamDescription = nil;
    self.communitiesName = nil;
    self.communiteDescription = nil;
    
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction)didPressCancelBtn:(id)sender{
    
}
- (IBAction)didPressPostBtn:(id)sender{
    
}
- (IBAction)didPressDeleteBtn:(id)sender{
    
}
- (IBAction)didPressLunchBtn:(id)sender{
    
    
}

@end
