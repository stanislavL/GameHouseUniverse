//
//  LoadingViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 10/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "LoadingViewController.h"
#import "GHUScreenManager.h"
#import "WelcomeViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController
@synthesize activity;

- (void) dealloc{
    
    NSLog(@"LoadingViewController dealloc");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
  
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDataLoadedNotification:) name:@"dataLoaded" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSignUpNotification:) name:@"signUp" object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView* temp = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 100, 200)];
    [UIView animateWithDuration:1.0 animations:^{
        temp.frame = CGRectMake(100, 200, 100, 200);
    } completion:^(BOOL finished) {
        NSLog(@"Position%@", NSStringFromCGPoint(temp.bounds.origin));
    }];
    enableVC = NO;

}

- (void) viewDidUnload{
    
    
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{

    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - Screen Operations
//======================================================================================================================================================================

- (void) dismissScreen{
    
    if (enableVC) {
        [[GHUScreenManager shared] goToScreen:@"tutorial"];
    }else{
      [[GHUScreenManager shared] goToScreen:@"root"];  
    }
    
    
    
}
- (void) didReceiveDataLoadedNotification:(NSNotification*) _notification{
    
    enableVC = NO;
    [self dismissScreen];

}
 @end
