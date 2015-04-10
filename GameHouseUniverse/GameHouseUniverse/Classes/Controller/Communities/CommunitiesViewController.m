//
//  CommunitiesViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "CommunitiesViewController.h"
#import "ProfileMenuViewController.h"
#import "UIView+Animation.h"

@interface CommunitiesViewController ()

@end

@implementation CommunitiesViewController

@synthesize contentView;
@synthesize searchCommunity;
@synthesize contentTable;
@synthesize badgeLabel;


//===============================================================================================================
#pragma mark -
#pragma mark - dealloc Method
//===============================================================================================================
- (void) dealloc{
    
    self.searchCommunity = nil;
    self.contentTable = nil;
    self.badgeLabel = nil;
    
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
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self setUpElement];
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
    
    showMenu = NO;
    dialog = [[GHUDialogView alloc] initWithNibName:[appDelegate getDeviceString:@"GHUDialogView" ] bundle:nil];
    menuView = [[ProfileMenuViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileMenuViewController" ] bundle:nil];
    menuView.pop = dialog;
    menuView.superViewController = self;
    
    [dialog.view setFrame:CGRectMake(-320 , 0, dialog.view.frame.size.width, dialog.view.frame.size.height)];
    [menuView.view setFrame:CGRectMake(-320 , 0, menuView.view.frame.size.width, menuView.view.frame.size.height)];
    
    [self.view addSubview:dialog.view];
    [self.view addSubview:menuView.view];

    
}
- (void) updateElement{
    
}

//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction)didPressMenuBtn:(id)sender{

    if (!showMenu) {
        showMenu = YES;
        [dialog.view moveTo:CGPointMake(0, dialog.view.frame.origin.y)
                   duration:0.3f
                     option:UIViewAnimationOptionCurveEaseIn];
        
        [menuView.view moveTo:CGPointMake(0, menuView.view.frame.origin.y)
                     duration:0.3f
                       option:UIViewAnimationOptionCurveEaseIn];
        
        [self.contentView moveTo:CGPointMake(280, self.view.frame.origin.y)
                        duration:0.3f
                          option:UIViewAnimationOptionCurveEaseIn];
        
        
    }else{
        showMenu = NO;
        [dialog.view moveTo:CGPointMake(-320, dialog.view.frame.origin.y)
                   duration:0.3f
                     option:UIViewAnimationOptionCurveEaseIn];
        
        [menuView.view moveTo:CGPointMake(-320, menuView.view.frame.origin.y)
                     duration:0.3f
                       option:UIViewAnimationOptionCurveEaseIn];
        
        [self.contentView moveTo:CGPointMake(0, self.view.frame.origin.y)
                        duration:0.3f
                          option:UIViewAnimationOptionCurveEaseIn];
    }
    

    
}
- (IBAction)didPressMessageBtn:(id)sender{
    
    NSLog(@"Message Button Pressed");
}
- (IBAction)didPressSearchBtn:(id)sender{
    
    NSLog(@"Search Button Pressed");
}
- (IBAction)didPressLaunchBtn:(id)sender{
    
    NSLog(@"Launch Button Pressed");
}
- (IBAction)didPressFilterBtn:(id)sender{
    
    NSLog(@"Filter Button Pressed");
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
