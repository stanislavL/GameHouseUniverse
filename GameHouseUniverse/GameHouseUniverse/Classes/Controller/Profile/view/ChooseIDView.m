//
//  ChooseIDView.m
//  GameHouseUniverse
//
//  Created by stanislav on 14/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "ChooseIDView.h"
#import "ProfileEditViewController.h"
#import "AddIDView.h"

@interface ChooseIDView ()

@end

@implementation ChooseIDView
@synthesize aryBtns, aryIDs, aryImages;
@synthesize pop;
@synthesize profile;

- (void) dealloc{
    
    NSLog(@"ChooseIDView dealloc");
    
    self.pop = nil;
    self.profile = nil;
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
- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
   
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithData];
    [self initWithView];
    
}

//*****************************************************************************************************************************************
#pragma mark -
#pragma mark - Screen Operation
//*****************************************************************************************************************************************
- (void) initWithView{
    
    selectedID = 0;
    float posX, posY,stepX,stepY, btnWidth, btnHeight;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        posX = 20.0f, posY = 77.0f;
        stepX = 50.0f, stepY = 60.0f;
        btnWidth = 40.0f , btnHeight = 45.0f;
    }else{
        posX = 57.0f, posY = 170.0f;
        stepX = 130.0f, stepY = 160.0f;
        btnWidth = 90.0f, btnHeight = 100.0f;
    }
    
    for (int i = 0; i<3; i++) {
        for (int j = 0; j < 5; j++) {
            UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGRect buttonRect = CGRectMake(posX + stepX*j, posY+stepY*i, btnWidth, btnHeight);
            [tempBtn setFrame:buttonRect];
            [tempBtn setTitle:nil forState:UIControlStateNormal];
            [tempBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.aryImages objectAtIndex:i*5+j]]] forState:UIControlStateNormal];
            [tempBtn setTag:i*5+j];
            [tempBtn addTarget:self action:@selector(gameIDsPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:tempBtn];
            //            [self.arryBtns addObject:tempBtn];
        }
    }

    
}
- (void) initWithData{
    
    self.aryBtns = [[NSMutableArray alloc] init];
    self.aryIDs = [[NSMutableArray alloc] initWithObjects:@"Battle.netID",
                                                          @"GamerTag",
                                                          @"PNS ID",
                                                          @"WiiU ID",
                                                          @"3Ds Code",
                                                          @"Wargaming.net",
                                                          @"SMITE ID",
                                                          @"Strife ID",
                                                          @"Origin ID",
                                                          @"Steam ID",
                                                          @"Twitch ID",
                                                          @"LolID",
                                                          @"Eve ID",
                                                          @"Minecraft ID",
                                                          @"Skype ID", nil];
  
    self.aryImages = [[NSMutableArray alloc] initWithObjects:@"Icon_Battlenet_ID.png",
                                                             @"Icon_XBOX_ID.png",
                                                             @"Icon_SEN_ID.png",
                                                             @"Icon_WiiU_ID.png",
                                                             @"Icon_3DS_ID.png",
                                                             @"Icon_Wargamingnet_ID.png",
                                                             @"Icon_SMITE_ID.png", //-- no sub games
                                                             @"Icon_Strife_ID.png",//--no sub games
                                                             @"Icon_Origin_ID.png",
                                                             @"Icon_Steam_ID.png",
                                                             @"Icon_Twitch_ID.png",//--no games
                                                             @"Icon_LoL_ID.png", //-no sub games
                                                             @"Icon_EVE_ID.png",
                                                             @"Icon_Minecraft_ID.png",//--no sub games
                                                             @"Icon_Skype_ID.png",/*--no games--*/ nil];


    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)didPressBackBtn:(id)sender{
    
    [self.profile setAddNewGameEnable:NO];
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    
}

- (void) gameIDsPressed:(id) sender{
    
    NSLog(@"gameID Button %ld Pressed" , (long)[sender tag]);
    int gameIDNumber = (int)[sender tag];
    
    self.view.userInteractionEnabled = NO;
    [self.view setHidden:YES];
    
    AddIDView* idView = [[AddIDView alloc] initWithNibName:[appDelegate getDeviceString:@"AddIDView" ] bundle:nil];
    idView.pop = self.pop;
    [self.profile.view addSubview:idView.view];
    idView.profile = self.profile;
    idView.choosIDView = self;
    [idView openWithVC:(NSString*)[self.aryIDs objectAtIndex:gameIDNumber] image:[NSString stringWithFormat:@"%@",[self.aryImages objectAtIndex:gameIDNumber]]];
  
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [idView.view setFrame:CGRectMake(20, 124, 280, 320)];
    }else{
        [idView.view setFrame:CGRectMake(59, 162, 650, 700)];
    }

    
    
}
- (void) enableView{
    self.view.userInteractionEnabled = YES;
    [self.view setHidden:NO];
}
@end
