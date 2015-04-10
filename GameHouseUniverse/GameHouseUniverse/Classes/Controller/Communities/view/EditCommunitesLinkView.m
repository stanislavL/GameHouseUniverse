//
//  EditCommunitesLinkView.m
//  GameHouseUniverse
//
//  Created by stanislav on 19/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "EditCommunitesLinkView.h"
#import "EditCommunitiesViewController.h"
@interface EditCommunitesLinkView ()

@end

@implementation EditCommunitesLinkView
@synthesize twitch, facebook, meetup, website, email;
@synthesize pop, editCommunities;

- (void) dealloc{
    
    self.twitch = nil;
    self.facebook = nil;
    self.website = nil;
    self.meetup = nil;
    self.email = nil;
    self.pop = nil;
    self.editCommunities = nil;
    
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) validateInput{
    
    return YES;
}
- (IBAction)didPresseUpdateBtn:(id)sender{
    
    NSLog(@"didPressed Update Button");
    
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
}
- (IBAction)didPresseAddBtn:(id)sender{
    
    NSLog(@"didPressed Add Button");

    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    
}

@end
