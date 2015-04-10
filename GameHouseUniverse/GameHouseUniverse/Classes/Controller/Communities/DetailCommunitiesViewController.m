//
//  DetailCommunitiesViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "DetailCommunitiesViewController.h"

@interface DetailCommunitiesViewController ()

@end

@implementation DetailCommunitiesViewController
@synthesize community;
@synthesize postBadgeLabel, postCount;
@synthesize messageBadgeLabel, badgeCount;
@synthesize aryLinks;
@synthesize segment;
@synthesize communityName, communityDescription, communityMembers, communitySubScribers;

//===============================================================================================================
#pragma mark -
#pragma mark - dealloc method
//===============================================================================================================
- (void) dealloc{
    
    self.community = nil;
    self.postBadgeLabel = nil;
    self.postCount = nil;
    self.badgeCount = nil;
    self.messageBadgeLabel = nil;
    
    self.communityName = nil;
    self.communityDescription = nil;
    self.communityMembers = nil;
    self.communitySubScribers = nil;
    
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self setUpElement];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
//===============================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//===============================================================================================================

- (void) openWithVC:(GHUCommunity *)item{
    
    self.community = item;
    self.communityName.text = item.name;
    self.communityDescription.text = item.description;
    self.communityMembers.text = [NSString stringWithFormat:@"%d members" , [item.members intValue]];
    self.communitySubScribers.text = [NSString stringWithFormat:@"%d members" , [item.subscribers intValue]];
    
    
}
- (void) setUpElement{
   
    self.view.tintColor = [UIColor colorWithRed:103.0f/255.0f green:85.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
    
}
- (void) updateElement{
    
}

//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction) didPressedSegment:(id)sender{
    
    NSInteger index = self.segment.selectedSegmentIndex;
    if (index == 0) {
        
        NSLog(@"About pressed");
        
    }else if(index == 1){
        
        NSLog(@"Posts Pressed");
        
    }else if(index == 2){
        
        NSLog(@"Events Pressed");
    }
    
}
- (IBAction)didPressedMenuBtn:(id)sender{
    
}
- (IBAction)didPressedMessageBtn:(id)sender{
    
}
- (IBAction)didPressedSearchBtn:(id)sender{
    
}
- (IBAction)didPressedSettingsBtn:(id)sender{
    
}
- (IBAction)didPressedJoinBtn:(id)sender{
    
}
- (IBAction)didPressedSubscribeBtn:(id)sender{
    
}

@end
