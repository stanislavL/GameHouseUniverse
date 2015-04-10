//
//  ProfileViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 06/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "ProfileViewController.h"
#import "FriendsViewController.h"
#import "MessengerViewController.h"
#import "FeedViewController.h"
#import "SettingsViewController.h"
#import "UIView+Animation.h"
#import "GameDetailViewController.h"
#import "AddGameViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


@synthesize contentView;
@synthesize profileImage;
@synthesize profileName;
@synthesize memberSince;
@synthesize userInfo;
@synthesize gameIDs;
@synthesize addFirstGameIDButton;
@synthesize addFirstGameIDLabel;
@synthesize selecteGameId;
@synthesize aryGameIDs;
@synthesize aryGameIDsName;

- (void) dealloc{
    
    self.profileName = nil;
    self.profileImage = nil;
    self.memberSince = nil;
    self.gameIDs = nil;
    self.userInfo = nil;

    
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
    [self setUpElement];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    
}
//==================================================================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//==================================================================================================================================================
- (void) setUpElement{
    
    self.aryGameIDs     =      [[[NSMutableArray alloc] init] autorelease];
    self.aryGameIDsName = [[[NSMutableArray alloc] init] autorelease];
    
    self.selecteGameId = [[[UIImage alloc] init] autorelease];
    showGameIDsView = NO;
    idsIndex = 0;
    
    //-------set userProfile-----------------------------------------
    self.userInfo = [[GHUDataManager shared] userInfo];
    if (self.userInfo.imageData) {
     
        self.profileImage.image = (UIImage*)self.userInfo.imageData;
     
    }
    [self.profileName setText:self.userInfo.username];
    [self.memberSince setText:[NSString stringWithFormat:@"member since %@" , self.userInfo.memberDate]];
    
    
    //---------GameIds image setting------------------------------------
    for (int i = 0; i< 10; i++) {
        UIButton* tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(buttonsPosition[i][0], buttonsPosition[i][1], 40.0f, 45.0f)];
        [tempBtn setTitle:nil forState:UIControlStateNormal];
        [tempBtn addTarget:self action:@selector(gameIDsPressed:) forControlEvents:UIControlEventTouchDown];
        tempBtn.hidden = YES;
        tempBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:tempBtn];
        [self.aryGameIDs addObject:tempBtn];
    }

    GHUDataManager* data = [GHUDataManager shared];
    NSMutableArray* gameIds = data.gameidsList;

    
    int index = 0;
    if ([gameIds count] > 0) {
        for (int i = 0; i <[gameIds count]; i++) {
            NSMutableDictionary* ids_data = (NSMutableDictionary*)[gameIds objectAtIndex:i];
            NSString* str = [ids_data objectForKey:@"img_name"];
            NSString* idsName = [ids_data objectForKey:@"ids_name"];
            UIButton* btn = (UIButton*)[self.aryGameIDs objectAtIndex:index];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@" , str]] forState:UIControlStateNormal];
            [self.aryGameIDsName addObject:[ids_data objectForKey:@"ids_name"] ];
            btn.hidden = NO;
            btn.userInteractionEnabled = YES;
            [btn setTag:index];
            if ([idsName isEqualToString:@"Skype ID"]) {
                [btn setTag:21];
            }else if([idsName isEqualToString:@"Twitch ID"]){
                [btn setTag:22];
            }else if([idsName isEqualToString:@"Minecraft ID"]){
                [btn setTag:23];
            }else if([idsName isEqualToString:@"Softnyx"]){
                [btn setTag:24];
            }else if([idsName isEqualToString:@"LolID"]){
                [btn setTag:25];
            }else if([idsName isEqualToString:@"Armor Games"]){
                [btn setTag:26];
            }
            
            index++;
            
        }
    }
    
    if ([[GHUSessionManager shared] newGamIds]) {
       
        self.addFirstGameIDButton.hidden = NO;
        self.addFirstGameIDLabel.hidden = NO;
    
    }else{
        
        self.addFirstGameIDButton.hidden = YES;
        self.addFirstGameIDLabel.hidden = YES;
        showGameIDsView = YES;

        if ((index < 10) && (index > 0)) {
            
            UIButton* btn = (UIButton*)[self.aryGameIDs objectAtIndex:index];
            [btn setImage:[UIImage imageNamed:@"add_role_btn.png"] forState:UIControlStateNormal];
            btn.hidden = false;
            btn.userInteractionEnabled = YES;
            [btn setTag:100];
        }

    }

    //*************ProileMenuViewController Setting****************************
    showMenu = NO;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
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
- (void) gameIDsPressed:(id) sender{
    
    UIButton* btn = sender;
    selecteGameId = [btn currentImage];
    idsIndex = (int)btn.tag;
    NSLog(@"index ==%d" , idsIndex);
    if ((idsIndex < 100) && (idsIndex > 20)) {
        return;
    }
    if (idsIndex == 100) {
       
        ProfileEditViewController* menuVC = [[[ProfileEditViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileEditViewController"] bundle:nil] autorelease];
        [self.navigationController pushViewController:menuVC animated:YES];
        

    }else{
        
        [self moveToEditView];
    }
                                                                           
}
- (void) moveToEditView{
    
    
    if (showGameIDsView) {
        GameDetailViewController* gameVC = [[[GameDetailViewController alloc] initWithNibName:[appDelegate getDeviceString:@"GameDetailViewController"] bundle:nil] autorelease];
        [self.navigationController pushViewController:gameVC animated:YES];
        [gameVC openWithVC:self.selecteGameId tagName:(NSString*)[self.aryGameIDsName objectAtIndex: idsIndex]];
        
    }else{
        ProfileEditViewController* menuVC = [[[ProfileEditViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileEditViewController"] bundle:nil] autorelease];
        [self.navigationController pushViewController:menuVC animated:YES];
        
    }

    
}
//==================================================================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//==================================================================================================================================================
- (IBAction)didPresseMenuBtn:(id)sender{
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
- (IBAction)didPresseAddGameIDBtn:(id)sender{
    
    [self moveToEditView];

}
- (IBAction)didPresseAddGameFeatureBtn:(id)sender{
    
    [self moveToEditView];
}
- (IBAction)didPresseAddGameCommunitiesBtn:(id)sender{
    
    [self moveToEditView];
}
- (IBAction)didPresseFriendBtn:(id)sender{
    
    [self updateElement];
    FriendsViewController* menuVC = [[[FriendsViewController alloc] initWithNibName:[appDelegate getDeviceString:@"FriendsViewController"] bundle:nil] autorelease];
	[self.navigationController pushViewController:menuVC animated:YES];

    
}

@end
