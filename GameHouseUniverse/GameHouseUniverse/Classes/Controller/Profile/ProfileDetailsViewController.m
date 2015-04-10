//
//  ProfileMenuViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 14/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "ProfileDetailsViewController.h"
#import "FeedViewController.h"
#import "MessengerViewController.h"
#import "SettingsViewController.h"
#import "GHUDialogView.h"
#import "RecentGameViewCell.h"
#import "ProfileMenuViewController.h"
#import "UIView+Animation.h"
#import "InviteGameView.h"
#import "GameDetailViewController.h"
@interface ProfileDetailsViewController ()
@end

@implementation ProfileDetailsViewController

@synthesize userInfo;
@synthesize profileImage;

@synthesize aryGameIdBtn, aryGameIdList, aryRows;
@synthesize aryGames,aryCommunities, aryFriends;

@synthesize contact;
@synthesize menuButton, searchButton, messageButton, settingsButton;
@synthesize listTableView;
@synthesize popView;
@synthesize username, memberDate;
@synthesize contentView;

- (void) dealloc{
   
    NSLog(@"ProfileDetailsViewController dealloc");
    
    [self.aryGameIdBtn removeAllObjects];
    [self.aryGames removeAllObjects];
    [self.aryCommunities removeAllObjects];
    [self.aryFriends removeAllObjects];
    
    [self.aryGameIdBtn release];
    [self.aryGames release];
    [self.aryCommunities release];
    [self.aryFriends release];
    
    self.aryGameIdBtn = nil;
    self.aryCommunities = nil;
    self.aryGames = nil;
    self.aryFriends = nil;
    self.contact = nil;
    self.listTableView = nil;
    self.popView = nil;
    
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

    self.aryGames       = [[[NSMutableArray alloc]init] autorelease];
    self.aryCommunities = [[[NSMutableArray alloc]init] autorelease];
    self.aryFriends     = [[[NSMutableArray alloc]init] autorelease];
    self.aryGameIdList  = [[[NSMutableArray alloc] init] autorelease];
    self.aryGameIdBtn   = [[[NSMutableArray alloc] init] autorelease];
    self.aryRows        = [[[NSMutableArray alloc] init] autorelease];
    
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

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}


//===============================================================================================================
#pragma mark -
#pragma mark - Screen Operat
//==========================================================================================================
- (void) setUpElement{

    for (int i = 0; i< 30; i++) {
        UIImage* img = [UIImage imageNamed:@"picture_bg.png"];
        [self.aryGames addObject:img];
        [self.aryCommunities addObject:img];
        [self.aryFriends addObject:img];
    }
    
    NSMutableDictionary* dict1 = [[[NSMutableDictionary alloc] init] autorelease];
    [dict1 setObject:self.aryGames forKey:@"game"];
    [dict1 setObject:self.aryCommunities forKey:@"commuity"];
    [dict1 setObject:self.aryFriends forKey:@"friends"];
    
    
    for (int i = 0; i< 10; i++) {
        UIButton* tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnPos[i][0], btnPos[i][1], 35.0f, 40.0f)];
        [tempBtn setTitle:nil forState:UIControlStateNormal];
        [tempBtn addTarget:self action:@selector(gameIDsPressed:) forControlEvents:UIControlEventTouchDown];
        tempBtn.hidden = YES;
        tempBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:tempBtn];
        [self.aryGameIdBtn addObject:tempBtn];
    }
    
    self.userInfo = [[GHUDataManager shared] userInfo];
    self.username.text = userInfo.username;
    if (self.userInfo.imageData) {
        self.profileImage.image = self.userInfo.imageData;
    }
    self.memberDate.text = [NSString stringWithFormat:@"member since %@" , self.userInfo.memberDate];
 
    //----------------Getting Data-----------------------------------------
    GHUDataManager* data = [GHUDataManager shared];
    NSMutableArray* gameIds = data.gameidsList;
   
    int index = 0;
    if ([gameIds count] > 0) {
        for (int i = 0; i <[gameIds count]; i++) {
            NSMutableDictionary* ids_data = (NSMutableDictionary*)[gameIds objectAtIndex:i];
            NSString* str = [ids_data objectForKey:@"img_name"];
            [self.aryGameIdList addObject:[ids_data objectForKey:@"ids_name"]];
            UIButton* btn = (UIButton*)[self.aryGameIdBtn objectAtIndex:index];
            [btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
            btn.hidden = NO;
            btn.userInteractionEnabled = YES;
            [btn setTag:index];
            index++;
            
        }
    }

    //----------------ProileMenuViewController Setting-----------------------------
    showMenu = NO;
    showRecent = NO;
    showCommunity = NO;
    showFriend = NO;
    showRows = NO;
    
    dialog = [[GHUDialogView alloc] initWithNibName:[appDelegate getDeviceString:@"GHUDialogView" ] bundle:nil];
    menuView = [[ProfileMenuViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileMenuViewController" ] bundle:nil];
    menuView.pop = dialog;
    enableProfile = YES;
    menuView.superViewController = self;
    
    
    [dialog.view setFrame:CGRectMake(-320 , 0, dialog.view.frame.size.width, dialog.view.frame.size.height)];
    [menuView.view setFrame:CGRectMake(-320 , 0, menuView.view.frame.size.width, menuView.view.frame.size.height)];
    
    [self.view addSubview:dialog.view];
    [self.view addSubview:menuView.view];
    [self.listTableView reloadData];
    
    
}
- (void) updateElement{
    
    
    
}
//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction)didPressMenuBtn:(id)sender{
    
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
- (IBAction)didPressMessageBtn:(id)sender{
  
    NSLog(@"MessageButton Pressed");
    FeedViewController* feedVC = [[[FeedViewController alloc] initWithNibName:[appDelegate getDeviceString:@"FeedViewController"] bundle:nil] autorelease];
	[self.navigationController pushViewController:feedVC animated:YES];
    
}
- (IBAction)didPressSettingsBtn:(id)sender{
    
//    SettingsViewController* settingVC = [[[SettingsViewController alloc] initWithNibName:[appDelegate getDeviceString:@"SettingsViewController"] bundle:nil] autorelease];
//	[self.navigationController pushViewController:settingVC animated:YES];
    
}
- (IBAction)didPressSearchBtn:(id)sender{
    
    NSLog(@"SearchButton Pressed");
    
}
- (IBAction)didPressInviteBtn:(id)sender{

    [self showInvteGamedialog];
}

- (void) gameIDsPressed:(id) sender{
    
    UIButton* btn = sender;
    UIImage* imge = [btn currentImage];
    NSInteger index = btn.tag;
    
    NSLog(@"index==%ld.....=%@" , (long)index, [self.aryGameIdList objectAtIndex:index]);
    
    GameDetailViewController* gameVC = [[[GameDetailViewController alloc] initWithNibName:[appDelegate getDeviceString:@"GameDetailViewController"] bundle:nil] autorelease];
    [self.navigationController pushViewController:gameVC animated:YES];
    [gameVC openWithVC:imge tagName:[self.aryGameIdList objectAtIndex:index]];
}
- (void) showInvteGamedialog{
    
    GHUDialogView* dialog_view = [[GHUDialogView alloc] initWithNibName:[appDelegate getDeviceString:@"GHUDialogView" ] bundle:nil];
    InviteGameView* idView = [[InviteGameView alloc] initWithNibName:[appDelegate getDeviceString:@"InviteGameView" ] bundle:nil];
    idView.pop = dialog_view;
    idView.superViewController = self;
    
    [self.view addSubview:dialog_view.view];
    [self.view addSubview:idView.view];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [idView.view setFrame:CGRectMake(20, 124, 280, 320)];
    }
    else
    {
        [idView.view setFrame:CGRectMake(59, 162, 650, 700)];
    }
    
}
 
-(void)tapAction:(UIButton *)sender{
    
    if (sender.tag == 0) {
        showRecent = !showRecent;
    }else if(sender.tag == 1){
        showCommunity = !showCommunity;
    }else if(sender.tag == 2){
        showFriend = !showFriend;
    }
    
    showRows = !showRows;
    
    [self.listTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];

    
}

//===============================================================================================================
#pragma mark -
#pragma mark - TableView delegate and Data Source
//===============================================================================================================
//------------------ Section Height Setting
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}
//------------------ Section Count Setting
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
//------------------ rows count Setting
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int tempNum;
    if (section == 0) {
        if (showRecent) {
            tempNum = 1;
        }else{
            tempNum = 0;
        }
    }else if(section == 1){
        if (showCommunity) {
            tempNum = 1;
        }else{
            tempNum = 0;
        }
    }else if(section == 2){
        if (showFriend) {
            tempNum = 1;
        }else{
            tempNum = 0;
        }
    }
    
    return tempNum;
}

//------------------ header View define------------------
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *tempV = [[UIView alloc]initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 50)];
    tempV.backgroundColor = [UIColor clearColor];
    
    GHULabel *label1 = [[GHULabel alloc]initWithFrame:CGRectMake(20, 0, 200, 50)];
    label1.font = [UIFont boldSystemFontOfSize:15.0f];
    if (section == 0) {
        label1.text = @"Most Recent Games Played";
    }else if(section ==1){
        label1.text = @"Communities";
    }else if(section ==2){
        label1.text = @"Friends";
    }
    GHULabel *label3 = [[GHULabel alloc]initWithFrame:CGRectMake(240, 15, 100, 30)];
    label3.font = [UIFont fontWithName:@"Arial" size:12];
    label3.text = @"See all";
    label3.textColor = [UIColor colorWithRed:77.0f/255.0f green:59.0f/255.0f blue:169/255.0f alpha:1.0f];
    
    
    UIImageView *tempImageV = [[UIImageView alloc]initWithFrame:CGRectMake(290, 15, 15, 10)];
   
    
    if (!showRows) {
        
        tempImageV.image = [UIImage imageNamed:@"close"];
        
    }else{
        tempImageV.image = [UIImage imageNamed:@"open"];
    }
    
     CALayer *_separatorL = [CALayer layer];
      _separatorL.frame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 1.0f);
      _separatorL.backgroundColor = [UIColor lightGrayColor].CGColor;
      [tempV.layer addSublayer:_separatorL];
    

    
    [tempV addSubview:label1];
    [tempV addSubview:label3];
    [tempV addSubview:tempImageV];
    
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = CGRectMake(0, 0, 320, 50);
    [tempBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.tag = section;
    [tempV addSubview:tempBtn];
    return tempV;
}


//------------------ Cell define
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecentGameViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecentGameViewCell"];
    
    if(!cell) {
        cell = (RecentGameViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"RecentGameViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    if (indexPath.section == 0) {
        [cell populateItem:self.aryGames];
    }else if(indexPath.section == 1){
        [cell populateItem:self.aryCommunities];
    }else if(indexPath.section == 2){
        [cell populateItem:self.aryFriends];
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return -1;
}




@end
