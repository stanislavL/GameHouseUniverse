//
//  WelcomeViewController.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "WelcomeViewController.h"
#import "ProfileMenuViewController.h"
#import "TutorialViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController
@synthesize userName;
@synthesize user;

- (void) dealloc{
    
    NSLog(@"WelcomeViewController dealloc");
    
    self.userName = nil;
    self.user = nil;
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
    [self performSelector:@selector(onProfile:) withObject:nil afterDelay:1.0];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) openVC:(GHUUserInfo*) _user{
    
    self.user = _user;
   
}

- (void) setUpElement{
    
    
}
- (void) onProfile:(NSTimer*) timer{
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    TutorialViewController* tutorialVC = [[[TutorialViewController alloc] initWithNibName:[appDelegate getDeviceString:@"TutorialViewController"] bundle:nil] autorelease];
	[self.navigationController pushViewController:tutorialVC animated:YES];


    
}
@end
