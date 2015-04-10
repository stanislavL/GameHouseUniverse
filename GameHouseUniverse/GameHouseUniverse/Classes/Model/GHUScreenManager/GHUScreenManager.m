//
//  GHUScreenManager.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "GHUScreenManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "StartViewController.h"
#import "GHUSessionManager.h"
#import "GHUDefaultsManager.h"
#import "LoadingViewController.h"
#import "WelcomeViewController.h"
#import "FeedViewController.h"
#import "TutorialViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation GHUScreenManager

static GHUScreenManager* _sharedManager = nil;

@synthesize rootViewController;

-(void)dealloc{

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	_sharedManager = nil;
	self.rootViewController = nil;

	[super dealloc];
}

+(GHUScreenManager*)shared {
	
	@synchronized(self){
		if(_sharedManager == NULL){
			_sharedManager = [[self alloc] init];
		}
	}
	
	return(_sharedManager);
}

+(BOOL)isIPad{
	
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

- (id) init{
	self = [super init];
	
	if(self){
		
        [self registerForNotifications];
        delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	}
	
	return self;
}

-(void)initRootViewController:(UIViewController *)_viewController{
	
    self.rootViewController = _viewController;
}

//========================================================================================================================================================
#pragma mark -
#pragma mark - Notifications
//========================================================================================================================================================
-(void)registerForNotifications{
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLogoutNotification:) name:@"loggedOut" object:nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLoginNotification:) name:@"loggedIn" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSessionChangedNotification:) name:@"sessionChanged" object:nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveFullLoadingStartedNotification:) name:@"fullLoadingStarted" object:nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRequestsReceivedNotification:) name:@"requestsReceived" object:nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDataLoadedNotification:) name:@"dataLoaded" object:nil];
}


-(void)didReceiveLogoutNotification:(NSNotification*)_notification{

	[self goToScreen:@"start"];
}

- (void)didReceiveLoginNotification:(NSNotification *)_notification{
	
    [self goToScreen:@"loading"];
}

- (void)didReceiveSessionChangedNotification:(NSNotification *)_notification{
	
    [self goToScreen:@"loading"];
}

- (void)didReceiveFullLoadingStartedNotification:(NSNotification*)_notification{
   
    //-------Full data loading---
    [self goToScreen:@"loading"];

}

- (void)didReceiveDataLoadedNotification:(NSNotification *)_notification{
	
	if([GHUSessionManager shared].newAccount){
		
        [[GHUDefaultsManager shared] setIntroSeen:YES];
		[self goToScreen:@"root"];
	}else{
        
        FeedViewController* loginVC = [[[FeedViewController alloc] initWithNibName:[delegate getDeviceString:@"FeedViewController"] bundle:nil] autorelease];
        UINavigationController* navigationVC = [[[UINib nibWithNibName:@"GHUCustomNavigationController" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
        navigationVC.viewControllers = [NSArray arrayWithObject:loginVC];
        
        [self.rootViewController dismissViewControllerAnimated:NO completion:nil];
        [self.rootViewController presentViewController:navigationVC animated:NO completion:nil];

	}
}

-(void)didReceiveRequestsReceivedNotification:(NSNotification*)_notification{
	   
    AudioServicesPlayAlertSound(1003);
}
//========================================================================================================================================================
#pragma mark -
#pragma mark - Screen Operations
//========================================================================================================================================================
-(void)goToScreen:(NSString *)screen{
    
	if([screen isEqualToString:@"login"]){
	
		LoginViewController* loginVC = [[[LoginViewController alloc] initWithNibName:[delegate getDeviceString:@"LoginViewController"] bundle:nil] autorelease];
        UINavigationController* navigationVC = [[[UINib nibWithNibName:@"GHUCustomNavigationController" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
		navigationVC.viewControllers = [NSArray arrayWithObject:loginVC];
        
        [self.rootViewController dismissViewControllerAnimated:NO completion:nil];
        [self.rootViewController presentViewController:navigationVC animated:NO completion:nil];
	}
    
	else if([screen isEqualToString:@"root"]){
		
        FeedViewController* loginVC = [[[FeedViewController alloc] initWithNibName:[delegate getDeviceString:@"FeedViewController"] bundle:nil] autorelease];
        UINavigationController* navigationVC = [[[UINib nibWithNibName:@"GHUCustomNavigationController" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
        navigationVC.viewControllers = [NSArray arrayWithObject:loginVC];
        
        [self.rootViewController dismissViewControllerAnimated:NO completion:nil];
        [self.rootViewController presentViewController:navigationVC animated:NO completion:nil];
	
    }else if([screen isEqualToString:@"loading"]){
		
        LoadingViewController* loadingVC = [[[LoadingViewController alloc] initWithNibName:[delegate getDeviceString:@"LoadingViewController"] bundle:nil] autorelease];
        [self.rootViewController dismissViewControllerAnimated:NO completion:nil];
        [self.rootViewController presentViewController:loadingVC animated:NO completion:nil];

    }else if([screen isEqualToString:@"tutorial"]){
        
        TutorialViewController* tutorialVC = [[[TutorialViewController alloc] initWithNibName:[delegate getDeviceString:@"TutorialViewController"] bundle:nil] autorelease];
        UINavigationController* navigationVC = [[[UINib nibWithNibName:@"GHUCustomNavigationController" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
        navigationVC.viewControllers = [NSArray arrayWithObject:tutorialVC];
        
        [self.rootViewController dismissViewControllerAnimated:NO completion:nil];
        [self.rootViewController presentViewController:navigationVC animated:NO completion:nil];
    }
}

@end