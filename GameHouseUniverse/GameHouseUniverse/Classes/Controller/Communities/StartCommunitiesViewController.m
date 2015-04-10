//
//  StartCommunitiesViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "StartCommunitiesViewController.h"

@interface StartCommunitiesViewController ()

@end

@implementation StartCommunitiesViewController
@synthesize name, game, city;
@synthesize  myImage, searchFriends;

- (void) dealloc{
    
    NSLog(@"StartCommunitiesView Controller dealloc");
    
    self.name = nil;
    self.game = nil;
    self.city = nil;
    
    self.myImage = nil;
    self.searchFriends = nil;
    
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
- (void) openWithVC:(NSString*) profileImage{
    
    [self.myImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", profileImage]]];
    
}
- (void) setUpElement{
    
}
- (void) updateElement{
    
    
}
-(void)hideKeyboard{
	
    [self.name resignFirstResponder];
	[self.game resignFirstResponder];
    [self.city resignFirstResponder];
    [self.searchFriends resignFirstResponder];
    
}
//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction) didPressMenuBtn:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
