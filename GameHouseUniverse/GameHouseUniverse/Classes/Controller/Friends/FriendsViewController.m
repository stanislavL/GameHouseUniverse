//
//  FriendsViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "FriendsViewController.h"
#import "ProfileMenuViewController.h"
#import "GHUDialogView.h"
#import "UIView+Animation.h"


@interface FriendsViewController ()

@end

@implementation FriendsViewController
@synthesize mainTagSearch, gameFilterSearch;
@synthesize segment;

//===============================================================================================================
#pragma mark -
#pragma mark - dealloc Method
//===============================================================================================================
- (void) dealloc{
    
    NSLog(@"FriendViewController deallc");
    
    self.mainTagSearch = nil;
    self.gameFilterSearch = nil;
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
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self setUpElement];
    
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
    
    self.view.tintColor = [UIColor colorWithRed:103.0f/255.0f green:85.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
    
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

- (void)hideKeyboard{
	
}
//===============================================================================================================
#pragma mark -
#pragma mark - DataManager
//===============================================================================================================
- (void) saveData{
    
    
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
- (IBAction)didPressSearchBtn:(id)sender{
    
    NSLog(@"SearchButton Pressed");
    
}
- (IBAction)didPressFilterBtn:(id)sender{
    
    NSLog(@"FilterButton Pressed");
    
}
- (IBAction)didPressContactBtn:(id)sender{
    
    NSLog(@"ContactButton Pressed");
    
}
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
