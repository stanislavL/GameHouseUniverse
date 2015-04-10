//
//  AddIDView.m
//  GameHouseUniverse
//
//  Created by stanislav on 17/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "AddIDView.h"
#import "GHUAlertView.h"
@interface AddIDView ()

@end

@implementation AddIDView

@synthesize originTextFiled, confirmTextFiled;
@synthesize originID;
@synthesize pop, profile;
@synthesize choosIDView;
@synthesize originName;
@synthesize alertAddID;
@synthesize gamerImageName;

//*****************************************************************************************************************************************
#pragma mark -
#pragma mark - dealloc Method 
//*****************************************************************************************************************************************
- (void) dealloc{
    
    self.originID = nil;
    self.originName = nil;
    self.originTextFiled = nil;
    self.confirmTextFiled = nil;
    self.alertAddID = nil;
    
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
//*****************************************************************************************************************************************
#pragma mark -
#pragma mark - Screen Operation
//*****************************************************************************************************************************************
- (void) openWithVC:(NSString*) idType  image:(NSString*) image{
    
    self.originID = idType;
   
    self.gamerImageName = image;
    [originIDImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", image]]];
    self.originName.text = self.originID;
    
    self.originTextFiled.placeholder = self.originID;
    self.confirmTextFiled.placeholder = [NSString stringWithFormat:@"ReType your %@" , self.originID];
}

- (BOOL) validateInput{
    NSString* originAlert = [NSString stringWithFormat:@"Please enter your ID for a %@", self.originID];
    NSString* originConfirmAlert = [NSString stringWithFormat:@"Please Confirm your ID for a %@", self.originID];

    
    if ([self.originTextFiled.text length] == 0) {
        
        self.alertAddID =[GHUAlertView alertWithTitle:NSLocalizedString(self.originID, nil) message:NSLocalizedString(originAlert , nil) delegate:nil];
        return NO;
    } else if([self.confirmTextFiled.text length] == 0){
        
        self.alertAddID =[GHUAlertView alertWithTitle:NSLocalizedString(@"Confirm ID", nil) message:NSLocalizedString(originConfirmAlert , nil) delegate:nil];
        return NO;
    }if (![self.originTextFiled.text isEqualToString:self.confirmTextFiled.text]) {
        
        self.alertAddID = [GHUAlertView alertWithTitle:NSLocalizedString(@"Invaild ID", nil) message:NSLocalizedString(@"Please entered Correctly ID." , nil) delegate:nil];
        return NO;
    }
    return YES;
}

- (void) hideKeyboard{
	
    [self.originTextFiled resignFirstResponder];
	[self.confirmTextFiled resignFirstResponder];
    
}

//*****************************************************************************************************************************************
#pragma mark -
#pragma mark - IBAction SetUp
//*****************************************************************************************************************************************

- (IBAction)didPressBackBtn:(id)sender{
    
    [self.choosIDView enableView];
    [self.view removeFromSuperview];
    
    
}
- (IBAction)didPressApplyBtn:(id)sender{
   
    if (![self validateInput])
        return;
    [self hideKeyboard];
    
    self.userInfo = profile.userInfo;
    [[GHUSessionManager shared] setNewGamIds:NO];
    [self resetData];
    [self.pop.view removeFromSuperview];
    [self.view removeFromSuperview];
    [self.profile moveToProfileView:self.userInfo];
    
   
}
//*****************************************************************************************************************************************
#pragma mark -
#pragma mark - IBAction SetUp
//*****************************************************************************************************************************************
- (void) resetData{
    
    NSMutableDictionary* data = [[[NSMutableDictionary alloc] init] autorelease];
    [data setObject:self.originID forKey:@"ids_name"];
    [data setObject:self.gamerImageName forKey:@"img_name"];
    [data setObject:self.originTextFiled.text forKey:self.originID];
    
    NSMutableArray* gamename = [[[NSMutableArray alloc] init] autorelease];
    [data setObject:gamename forKey:@"game_name"];
    [[[GHUDataManager shared] gameidsList] addObject:data];
    
    [[GHUDefaultsManager shared] setProfileData:[[GHUDataManager shared] gameidsList]];
    
        
}
//======================================================================================================================================================================
#pragma mark -
#pragma mark - UIAlertView Delegate
//======================================================================================================================================================================

- (void) alertView:(UIAlertView*) alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == self.alertAddID) {
        if (buttonIndex == 0) {
            
        }else{
            
        }
    }
}

@end
