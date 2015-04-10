//
//  InviteGameView.m
//  GameHouseUniverse
//
//  Created by stanislav on 17/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "InviteGameView.h"
#import "ProfileDetailsViewController.h"
#import "MessengerViewController.h"
#import "FriendsViewController.h"
#import "FeedViewController.h"
#import "CommunitiesViewController.h"

@interface InviteGameView ()

@end

@implementation InviteGameView

@synthesize pop;
@synthesize superViewController;

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
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressInviteBtn:(id)sender{
    
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    
    enableProfile = NO;
    FeedViewController* messengerVC = [[[FeedViewController alloc] initWithNibName:[appDelegate getDeviceString:@"FeedViewController"] bundle:nil] autorelease];
    [self.superViewController.navigationController pushViewController:messengerVC animated:YES];
    
}
- (IBAction)didPressFriendsBtn:(id)sender{
    
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    enableProfile = NO;
    FriendsViewController* friendVC = [[[FriendsViewController alloc] initWithNibName:[appDelegate getDeviceString:@"FriendsViewController"] bundle:nil] autorelease];
    [self.superViewController.navigationController pushViewController:friendVC animated:YES];
}
- (IBAction)didPressCommunitesBtn:(id)sender{
    
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    enableProfile = NO;
    CommunitiesViewController* communityVC = [[[CommunitiesViewController alloc] initWithNibName:[appDelegate getDeviceString:@"CommunitiesViewController"] bundle:nil] autorelease];
    [self.superViewController.navigationController pushViewController:communityVC animated:YES];
}
- (IBAction)didPressBackBtn:(id)sender{
    
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
}

@end
