//
//  GHUViewController.m
//  Game Hours Universe
//
//  Created by stanislav on 12/10/14.
//
//

#import "GHUViewController.h"

@interface GHUViewController ()

@end

@implementation GHUViewController
@synthesize activeViewController;

- (void) dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupElements];
    }
    return self;
}
- (void) awakeFromNib{
    [self setupElements];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidUnload{
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.activeViewController viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.activeViewController viewWillDisappear:animated];
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{

    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void) setupElements{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivDataUpdatedNotification) name:@"dataUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivDataLoadedNotification) name:@"dataLoaded" object:nil];
}

- (void) didReceivDataUpdatedNotification{
    
}
- (void) didReceivDataLoadedNotification{
    
    
}
@end
