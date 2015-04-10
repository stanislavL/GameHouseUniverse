//
//  FriendsListViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 13/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "FriendsListViewController.h"


@interface FriendsListViewController ()

@end

@implementation FriendsListViewController
@synthesize strMessage, strRequest;
@synthesize contentTable;
@synthesize mainTagSearch;
@synthesize segment;
//===============================================================================================================
#pragma mark -
#pragma mark - dealloc Method
//===============================================================================================================
- (void) dealloc{
    
    self.contentTable.dataSource = nil;
    self.contentTable.delegate = nil;
    self.strRequest = nil;
    self.strMessage = nil;
    self.mainTagSearch = nil;
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
    [self setUpElement];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//===============================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//===============================================================================================================

- (void) setUpElement{
    
    self.view.tintColor = [UIColor colorWithRed:103.0f/255.0f green:85.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
}
- (void) updateElement{
    
}
- (void) openWithVC{
    
    
}
//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction) didPressedSegment:(id)sender{
    
    NSInteger index = self.segment.selectedSegmentIndex;
    if (index == 0) {
        
        NSLog(@"Friends pressed");
        
    }else if(index == 1){
        
        NSLog(@"Request Pressed");
        
    }
    
}
- (IBAction)didPressMenuBtn:(id)sender{
    
    [self updateElement];

    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ProfileMenuViewController* menuVC = [[[ProfileMenuViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileMenuViewController"] bundle:nil] autorelease];
	[self.navigationController pushViewController:menuVC animated:YES];
    
}
- (IBAction)didPressMessageBtn:(id)sender{
    
}
- (IBAction)didPressSearchBtn:(id)sender{
    
    
}
- (IBAction)didPressInviteBtn:(id)sender{
    
}
- (IBAction)didPressFilterBtn:(id)sender{
    
    
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

//===============================================================================================================
#pragma mark -
#pragma mark - UISearchDisplayController Delegate Method
//===============================================================================================================
- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    return YES;
}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    
    
    return YES;
}

@end
