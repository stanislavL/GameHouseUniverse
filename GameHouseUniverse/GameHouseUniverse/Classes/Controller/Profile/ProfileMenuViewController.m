//
//  ProfileViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "ProfileMenuViewController.h"
#import "AppDelegate.h"
#import "TutorialViewController.h"
#import "FriendsViewController.h"
#import "ProfileDetailsViewController.h"
#import "FeedViewController.h"
#import "CommunitiesViewController.h"
#import "UIViewController+ALViewController.h"
#import "LoginViewController.h"

@interface ProfileMenuViewController ()

@end

@implementation ProfileMenuViewController

@synthesize superViewController;
@synthesize userInfo;
@synthesize userName,userMemberSince;
@synthesize profileImage;
@synthesize pop;

- (void) dealloc{
    
    self.userName = nil;
    self.userInfo = nil;
    
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
- (void) viewDidUnload{
    
    [super viewDidUnload];
}

- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
//==================================================================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//==================================================================================================================================================
- (void) setUpElement{
    
    self.userInfo = [[GHUDataManager shared] userInfo];

    [self.view setFrame:CGRectMake(-200, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.userName.text = self.userInfo.username;
    self.userMemberSince.text = [NSString stringWithFormat:@"member since %@" , self.userInfo.memberDate];
    if (self.userInfo.imageData) {
        self.profileImage.image = self.userInfo.imageData;
    }
    
   
}
//==================================================================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//==================================================================================================================================================
- (IBAction)didPressViewProfileBtn:(id)sender{
    
    if (enableProfile) {
        return;
    }
    
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    
    ProfileDetailsViewController* profileVC = [[[ProfileDetailsViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileDetailsViewController"] bundle:nil] autorelease];
    [self.superViewController.navigationController pushViewController:profileVC animated:YES];

}
- (IBAction)didPressEditProfileBtn:(id)sender{
    
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];

    ProfileEditViewController* profileVC = [[[ProfileEditViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileEditViewController"] bundle:nil] autorelease];
	[self.superViewController.navigationController pushViewController:profileVC animated:YES];
    [profileVC openWithVC:YES];
    
}
//-----------TeamBuilder Btn Action------------
- (IBAction) didPressTeamBuilderBtn:(id)sender{
    
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    
    enableProfile = NO;
    FeedViewController* feedVC = [[[FeedViewController alloc] initWithNibName:[appDelegate getDeviceString:@"FeedViewController"] bundle:nil] autorelease];
    [self.superViewController.navigationController pushViewController:feedVC animated:YES];
}
//-----------Friend Btn Action------------
- (IBAction)didPressFriendBtn:(id)sender{

    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    
    enableProfile = NO;
    FriendsViewController* friendVC = [[[FriendsViewController alloc] initWithNibName:[appDelegate getDeviceString:@"FriendsViewController"] bundle:nil] autorelease];
	[self.superViewController.navigationController pushViewController:friendVC animated:YES];
    
}
//-----------Community Btn Action------------
- (IBAction) didPressCommunitiesBtn:(id)sender{
    
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    enableProfile = NO;
    CommunitiesViewController* feedVC = [[[CommunitiesViewController alloc] initWithNibName:[appDelegate getDeviceString:@"CommunitiesViewController"] bundle:nil] autorelease];
	[self.superViewController.navigationController  pushViewController:feedVC animated:YES];
}
//-----------Logout Btn Action------------
- (IBAction) didPressLogoutBtn:(id)sender{
   
    NSLog(@"Logout Btn Pressed");
//    [[GHUSessionManager shared] logoutWithDelegate:self success:@selector(logoutSuccess:) failure:@selector(logoutFailure:)];
    [[GHUDataManager shared] resetData];
    
    LoginViewController* loginVC = [[[LoginViewController alloc] initWithNibName:[appDelegate getDeviceString:@"LoginViewController"] bundle:nil] autorelease];
    [self.superViewController.navigationController pushViewController:loginVC animated:YES];
    
}
#pragma mark - Logout Delegate

-(void)logoutSuccess:(GHUApiRequest*)_request{
    
    [self dismissScreenAnimated:NO];
}

- (void)logoutFailure:(GHUApiRequest*)_request{
    
     }


@end
