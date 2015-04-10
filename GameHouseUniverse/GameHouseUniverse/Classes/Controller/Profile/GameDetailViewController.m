//
//  GameDetailViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 24/01/15.
//  Copyright (c) 2015 stanislav. All rights reserved.
//

#import "GameDetailViewController.h"
#import "GHUDataManager.h"
#import "GHUDefaultsManager.h"
#import "GHUSessionManager.h"
#import "AddGameViewController.h"
#import "InviteGameView.h"
#import "UIView+Animation.h"
#import "RecentGameViewCell.h"
@interface GameDetailViewController ()

@end

@implementation GameDetailViewController

@synthesize userInfo;
@synthesize contentView;
@synthesize idsButton;
@synthesize userName;
@synthesize memberDate;
@synthesize gameIdName;
@synthesize GametagName;
@synthesize addGameButton, addGameLabel;
@synthesize aryRecentGame, aryCommunities, aryFriends, arySubGameBtn, arySubGameList;
@synthesize listTableView;

- (void) dealloc{
    
    self.userInfo = nil;
    self.contentView = nil;
    self.idsButton = nil;
    self.userName = nil;
    self.memberDate = nil;
    self.gameIdName = nil;
    self.addGameLabel = nil;
    self.addGameButton = nil;
    self.aryRecentGame = nil;
    self.aryCommunities = nil;
    self.aryFriends  = nil;
    
    [super dealloc];
    
}
- (void)viewDidLoad {

    [super viewDidLoad];
    [self setUpElement];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//==================================================================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//==================================================================================================================================================
- (void) openWithVC:(UIImage*) idsName tagName:(NSString*) tagName{
    
    self.gameIdName = idsName;
    self.GametagName = tagName;

    
}
- (void) setUpElement{
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self loadData];
    showMenu = NO;
    enableGameList = NO;
    showMenu = NO;
    showRecent = NO;
    showCommunity = NO;
    showFriend = NO;
    showRows = NO;
    
    self.userInfo = [[GHUDataManager shared] userInfo];
    self.userName.text = self.userInfo.username;
    self.memberDate.text = [NSString stringWithFormat:@"member since %@" , self.userInfo.memberDate];
    
    //---------SubGameBtn image setting------------------------------------
    for (int i = 0; i< 10; i++) {
        UIButton* tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(buttonsPosition[i][0], buttonsPosition[i][1], 40.0f, 45.0f)];
        [tempBtn setTitle:nil forState:UIControlStateNormal];
        [tempBtn addTarget:self action:@selector(gameIDsPressed:) forControlEvents:UIControlEventTouchDown];
        tempBtn.hidden = YES;
        tempBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:tempBtn];
        [self.arySubGameBtn addObject:tempBtn];
    }
    
    GHUDataManager* data = [GHUDataManager shared];
    NSMutableArray* gameIds = data.gameidsList;
    

    if ([gameIds count] > 0) {
        enableGameList = YES;
        for (int i = 0; i <[gameIds count]; i++) {
            NSMutableDictionary* dict = (NSMutableDictionary*)[gameIds objectAtIndex:i];
            NSString* idsName = [dict objectForKey:@"ids_name"];
            if ([idsName isEqualToString:self.GametagName]) {
                NSMutableArray* games = [[dict objectForKey:@"game_name"] mutableCopy];
                [self.arySubGameList addObjectsFromArray:games];
                for (int j = 0; j< [games count]; j++) {
                    UIButton* btn = [self.arySubGameBtn objectAtIndex:j];
                    [btn setImage:[UIImage imageNamed:@"picture_bg.png"] forState:UIControlStateNormal];
                    [btn setTag:j];
                    btn.hidden = NO;
                    btn.userInteractionEnabled = YES;
                    
                }
                
            }
        }
    }

    //*********************** ids button image setting Begin *****************************************************
    [self.idsButton setImage:self.gameIdName forState:UIControlStateNormal];
    UIImageView* test = [[UIImageView alloc] initWithFrame:CGRectMake(136, 191, 48, 48)];
    [test setImage:self.gameIdName];
    [self.view addSubview:test];
    //*********************** ids button image setting End ********************************************************

    
    //************************ProfileMenuViewController Dialog adding  Begin*****************************************
    dialog = [[GHUDialogView alloc] initWithNibName:[appDelegate getDeviceString:@"GHUDialogView" ] bundle:nil];
    menuView = [[ProfileMenuViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileMenuViewController" ] bundle:nil];
    menuView.pop = dialog;
    menuView.superViewController = self;
    [dialog.view setFrame:CGRectMake(-320 , 0, dialog.view.frame.size.width, dialog.view.frame.size.height)];
    [menuView.view setFrame:CGRectMake(-320 , 0, menuView.view.frame.size.width, menuView.view.frame.size.height)];
    [self.view addSubview:dialog.view];
    [self.view addSubview:menuView.view];
   
    //************************ProfileMenuViewController Dialog adding  End**********************************************
    if (enableGameList) {
        self.addGameButton.hidden = YES;
        self.addGameButton.userInteractionEnabled = NO;
        self.addGameLabel.hidden = YES;
        self.beforeView.hidden = YES;
        self.inviteGameBtn.hidden = NO;
        self.inviteGameBtn.userInteractionEnabled = YES;
        self.idsButton.hidden = YES;
        self.idsButton.userInteractionEnabled = NO;
    }else{
        self.inviteGameBtn.hidden = YES;
        self.inviteGameBtn.userInteractionEnabled = NO;
    }

}
- (void) moveToAddGameView{
    
    AddGameViewController* addGameVC = [[[AddGameViewController alloc] initWithNibName:[appDelegate getDeviceString:@"AddGameViewController"] bundle:nil] autorelease];
    [self.navigationController pushViewController:addGameVC animated:YES];
    [addGameVC openWithVC:self.gameIdName idStr:self.GametagName];
}
- (void) gameIDsPressed:(id) sender{
    
    
}
//==================================================================================================================================================
#pragma mark -
#pragma mark - Data Loading
//==================================================================================================================================================
- (void) loadData{
    
    self.arySubGameBtn = [[NSMutableArray alloc] init];
    self.arySubGameList = [[NSMutableArray alloc] init];
    
    self.aryRecentGame = [[NSMutableArray alloc] init];
    self.aryCommunities = [[NSMutableArray alloc] init];
    self.aryFriends = [[NSMutableArray alloc] init];
    
}

//==================================================================================================================================================
#pragma mark -
#pragma mark - IBAction Setup
//==================================================================================================================================================
- (IBAction) didPressIDsBtn:(id)sender{
    

    ProfileViewController* profileVC = [[[ProfileViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileViewController"] bundle:nil] autorelease];
    [self.navigationController pushViewController:profileVC animated:YES];

}

- (IBAction) didPressMenuBtn:(id)sender{
    
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
- (IBAction) didPressRecentGameBtn:(id)sender{
    
    [self moveToAddGameView];
}
- (IBAction) didPressCommunityGameBtn:(id)sender{
   
    [self moveToAddGameView];
}
- (IBAction) didPressFriendGameBtn:(id)sender{
    
    [self moveToAddGameView];
}

- (IBAction) didPressAddGameBtn:(id)sender{
    
    [self moveToAddGameView];
}
- (IBAction)didPresInviteGameBtn:(id)sender{
    
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
        [cell populateItem:self.aryRecentGame];
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
