//
//  EditCommunitiesViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "EditCommunitiesViewController.h"

@interface EditCommunitiesViewController ()

@end

@implementation EditCommunitiesViewController
@synthesize communityName;
@synthesize searchCommunities;
@synthesize contentTable;

- (void) dealloc{
    
    self.searchCommunities = nil;
    self.communityName = nil;
    self.contentTable = nil;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
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
- (IBAction)didPressMenuBtn:(id)sender{
    
}
- (IBAction)didPressMessageBtn:(id)sender{
    
}
- (IBAction)didPressSearchBtn:(id)sender{
    
}
- (IBAction)didPressSettingsBtn:(id)sender{
    
}
- (IBAction)didPressFounderBtn:(id)sender{
    
}
//===============================================================================================================
#pragma mark -
#pragma mark - ContentTable delegate
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
