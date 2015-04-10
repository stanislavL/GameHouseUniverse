//
//  TutorialViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "TutorialViewController.h"



@interface TutorialViewController () <GHUSwipeViewDataSource, GHUSwipeViewDelegate>

@property (nonatomic, assign) IBOutlet GHUSwipeView *swipeView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation TutorialViewController
@synthesize gameIDs;
@synthesize userInfo;
- (void)dealloc
{
    self.swipeView.delegate = nil;
    self.swipeView.dataSource = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)awakeFromNib
{
   
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _items = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++)
    {
        [_items addObject:[NSString stringWithFormat:@"Tutorial Page %d" , i]];
    }
    
    self.swipeView.pagingEnabled = YES;

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInSwipeView:(GHUSwipeView *)swipeView
{
    return [_items count];
}

- (UIView *)swipeView:(GHUSwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    NSLog(@"index value == %ld" , (long)index);
    
    if (index == 4) {
        
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        ProfileViewController* profileVC = [[[ProfileViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileViewController"] bundle:nil] autorelease];
        [self.navigationController pushViewController:profileVC animated:YES];
    }
 
    if (view == nil)
    {

        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50*fy];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {

        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;

    view.backgroundColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    

    label.text = [_items objectAtIndex:index];
    
    return view;
}

- (CGSize)swipeViewItemSize:(GHUSwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

@end



