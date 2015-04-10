//
//  MessengerViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "MessengerViewController.h"
#import "ProfileMenuViewController.h"
@interface MessengerViewController ()

@end


@implementation MessengerViewController

@synthesize feedlabel;
@synthesize activelabel;
@synthesize activeViewController;

//===============================================================================================================
#pragma mark -
#pragma mark - dealloc Method
//===============================================================================================================
- (void) dealloc{
    
    self.feedlabel = nil;
    self.activelabel = nil;
    self.activeViewController = nil;
    
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

//===============================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//===============================================================================================================
- (void) openWithVC:(GHUUserInfo*) userInfo{
    
}
- (void) setupElement{
    NSLog(@"setup screen element");
}
- (void) updateElement{
    NSLog(@"update screen element");
    
}
//===============================================================================================================
#pragma mark -
#pragma mark - Data SetUp
//===============================================================================================================
- (void) saveData{

    NSLog(@"data save");
    
}
//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction)didPressBackBtn:(id)sender{
    
    [self saveData];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ProfileMenuViewController* menuVC = [[[ProfileMenuViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileMenuViewController"] bundle:nil] autorelease];
	[self.navigationController pushViewController:menuVC animated:YES];
}
- (IBAction)didPressSearchBtn:(id)sender{
    NSLog(@"SearchButton Pressed");
    
}
- (IBAction)didPressFeedBtn:(id)sender{
    NSLog(@"FeedButton Pressed");
}
- (IBAction)didPressActiveBtn:(id)sender{
    NSLog(@"ActiveButton Pressed");
}
- (IBAction)didPressArchiveBtn:(id)sender{
    NSLog(@"ArchiveButton Pressed");
}
- (IBAction)didPressNewGameBtn:(id)sender{
    NSLog(@"NewGameButton Pressed");
    
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
