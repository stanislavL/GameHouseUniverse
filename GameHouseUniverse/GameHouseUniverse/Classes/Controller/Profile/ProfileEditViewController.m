//
//  ProfileEditViewController.m
//  GameHouseUniverse
//
//  Created by Admin on 1/27/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ProfileEditViewController.h"
#import "GHUDataManager.h"
#import "GHUDefaultsManager.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "InviteGameView.h"
#import "GHUDialogView.h"
#import "ChooseIDView.h"
#import "ProfileMenuViewController.h"
#import "ProfileViewController.h"
#import "ProfileDetailsViewController.h"
#import "UIImage+ALExtended.h"
#import "GamesCell.h"
#import "AddGameViewController.h"

@interface ProfileEditViewController ()

@end

@implementation ProfileEditViewController

@synthesize addNewGameEnable;
@synthesize contentTable, profileImage;
@synthesize treeOpenArray, treeOpenString;
@synthesize aryGameIDs;
@synthesize userInfo;
@synthesize profile;


- (void) dealloc{
    
    [super dealloc];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.treeOpenArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpElement];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) openWithVC:(BOOL) enableDialog{
    
    dialogEnable = enableDialog;
}
//===============================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//===============================================================================================================
- (void)moveToProfileView:(GHUUserInfo *)userInfo{
    
    ProfileViewController* profileVC = [[[ProfileViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileViewController"] bundle:nil] autorelease];
    [self.navigationController pushViewController:profileVC animated:YES];
    
}
- (void) moveToAddGameView:(NSIndexPath*) index{
    
    UIImage* img = [UIImage imageNamed:[[self.aryGameIDs objectAtIndex:index.section] objectForKey:@"img_name"]];
    NSString* gameIdName = [[self.aryGameIDs objectAtIndex:index.section] objectForKey:@"ids_name"];
    
    [[[GHUDataManager shared] gameidsList] removeAllObjects];
    [[[GHUDataManager shared] gameidsList] addObjectsFromArray:self.aryGameIDs];
    
    AddGameViewController* addGameVC = [[[AddGameViewController alloc] initWithNibName:[appDelegate getDeviceString:@"AddGameViewController"] bundle:nil] autorelease];
    [self.navigationController pushViewController:addGameVC animated:YES];
    [addGameVC openWithVC:img idStr:gameIdName];
    
}
- (void) setUpElement{
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.addNewGameEnable = NO;

    self.profile = [[GHUDataManager shared] gamerProfile];
    
    self.userInfo = [[GHUDataManager shared] userInfo];
    if (self.userInfo.imageData) {
        self.profileImage.image = self.userInfo.imageData;
    }
   
    self.aryGameIDs = [[[NSMutableArray alloc] init] autorelease];
    self.aryGameIDs = [[[GHUDataManager shared] gameidsList] mutableCopy];
    if (dialogEnable) {
        [self addSelectGameIDView];
    }

}

- (void) updateElement{
    
    [self.contentTable reloadData];
}
- (void) addSelectGameIDView{

    self.addNewGameEnable = YES;
    
    GHUDialogView* dialog_view = [[GHUDialogView alloc] initWithNibName:[appDelegate getDeviceString:@"GHUDialogView" ] bundle:nil];
    ChooseIDView* idView = [[ChooseIDView alloc] initWithNibName:[appDelegate getDeviceString:@"ChooseIDView" ] bundle:nil];
    idView.pop = dialog_view;
    idView.profile = self;
    
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
//===============================================================================================================
#pragma mark -
#pragma mark - Data Management Method
//===============================================================================================================
- (void) saveData{
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.aryGameIDs options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Output: %@", jsonString);
    
    if ([[GHUDataManager shared] profileRunning]) {
        //--------gameids data update to server
        [[GHUDataManager shared] profileUpdate: jsonString delegate:self success:@selector(contactCreateSuccess:) failure:@selector(contactFailed:)];
    
    }else{
        //--------gameids data create to server
        [[GHUDataManager shared] profileCreate:jsonString delegate:self success:@selector(contactCreateSuccess:) failure:@selector(contactFailed:)];
        [[GHUDataManager shared] setProfileRunning:YES];
  
        
    }
   
}

- (void)contactCreateSuccess:(GHUApiRequest *)_request{
    
    NSLog(@"profileCreated");
}
- (void)contactFailed:(GHUApiRequest *)_request{

    NSLog(@"profileFailed");
}
//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction) didPressEditPictureBtn:(id)sender{
    
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
//  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}
- (IBAction) didPressApplyBtn:(id)sender{
    
    [self saveData];
    ProfileDetailsViewController* profileVC = [[[ProfileDetailsViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileDetailsViewController"] bundle:nil] autorelease];
    [self.navigationController pushViewController:profileVC animated:YES];
    
}
- (IBAction)didPressAddNewIDBtn:(id)sender{
    
    if (!self.addNewGameEnable)
        [self addSelectGameIDView];
    
    
    
}
-(void)tapAction:(UIButton *)sender{
   
    self.treeOpenString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    if ([self.treeOpenArray containsObject:self.treeOpenString]) {
        
        [self.treeOpenArray removeObject:self.treeOpenString];

    }else{
      
        [self.treeOpenArray addObject:self.treeOpenString];
    }
    
   
    [self.contentTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];

    
}
//======================================================================================================================================================================
#pragma mark -
#pragma mark - UIImagePickerViewController delegate
//======================================================================================================================================================================
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * origImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    UIImage* editImage = [[[UIImage alloc] init] autorelease];
    
    int topOffset = (origImage.size.height - origImage.size.width) / 2;
    CGFloat regularSize = 0.0f;
    
    if (topOffset > 0) {
        regularSize = origImage.size.height;
        editImage = [origImage imageRotatedByDegrees:90.0];
        
    }else{
        regularSize = origImage.size.width;
        editImage = [origImage imageRotatedByDegrees:0.0];
        
    }
    
    
    CGRect cropRect = CGRectMake(0, topOffset, regularSize, regularSize);
    CGImageRef imageRef = CGImageCreateWithImageInRect(editImage.CGImage, cropRect);
    
    UIImage *cropImage = [UIImage imageWithCGImage:imageRef scale:editImage.scale orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    UIImage * maskImage = [UIImage imageNamed:@"picture_bg.png"];
    UIImage * maskedImage = [self doImageMask:cropImage withMask:maskImage];
    //Profile Image Setting
    self.profileImage.image = maskedImage;

    //------save profile image in local db---------
    [[GHUDefaultsManager shared] setProfileImage:maskedImage];
    self.userInfo.imageData = maskedImage;
}


- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage*) doImageMask:(UIImage *)mainImage withMask:(UIImage *)maskImage{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate(NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    
    
    if (mainViewContentContext == NULL){
        return NULL;
    }
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width/ mainImage.size.width;
    
    if(ratio * mainImage.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ mainImage.size.height;
    }
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {{-((mainImage.size.width*ratio)-maskImage.size.width)/2 , -((mainImage.size.height*ratio)-maskImage.size.height)/2}, {mainImage.size.width*ratio, mainImage.size.height*ratio}};
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, mainImage.CGImage);
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
}

//**********************************************************************************************************************************************
#pragma mark -
#pragma mark - GamerTag TableViewController Delegate and DataSource

//**********************************************************************************************************************************************
//------------------ Section Height Setting
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}
//------------------ Section Count Setting
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.aryGameIDs count];
}
//------------------ rows count Setting
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    int tempNum = (int)[[[self.aryGameIDs objectAtIndex:section] objectForKey:@"game_name"] count];
    
    NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];

    if ([self.treeOpenArray containsObject:tempSectionString]) {
        
        return tempNum+1;
    }
    return 0;

}

//------------------ header View define------------------
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *tempV = [[UIView alloc]initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 50)];
    tempV.backgroundColor = [UIColor clearColor];
    
    GHULabel *label1 = [[GHULabel alloc]initWithFrame:CGRectMake(65, 15, 100, 30)];
    label1.font = [UIFont fontWithName:@"Arial" size:18];
    label1.text = [[self.aryGameIDs objectAtIndex:section] objectForKey:@"ids_name"];
    
    GHULabel *label2 = [[GHULabel alloc]initWithFrame:CGRectMake(165, 15, 60, 30)];
    label2.font = [UIFont fontWithName:@"Arial" size:12];
    label2.text = [[self.aryGameIDs objectAtIndex:section] objectForKey:[NSString stringWithFormat:@"%@" , label1.text]];
    label2.textColor = [UIColor colorWithRed:195.0f/255.0f green:198.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    
    GHULabel *label3 = [[GHULabel alloc]initWithFrame:CGRectMake(255, 15, 100, 30)];
    label3.font = [UIFont fontWithName:@"Arial" size:12];
    label3.text = @"Edit";
    label3.textColor = [UIColor colorWithRed:77.0f/255.0f green:59.0f/255.0f blue:169/255.0f alpha:1.0f];
    
    
    
    UIImageView* iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(12,8, 40, 45)];
    iconImgV.image = [UIImage imageNamed:[[self.aryGameIDs objectAtIndex:section] objectForKey:@"img_name"]];
    
    
    UIImageView *tempImageV = [[UIImageView alloc]initWithFrame:CGRectMake(286, 25, 20, 11)];
    NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];
    if ([self.treeOpenArray containsObject:tempSectionString]) {
        tempImageV.image = [UIImage imageNamed:@"close"];
        
    }else{
        tempImageV.image = [UIImage imageNamed:@"open"];
    }

    if (section > 0) {
        CALayer *_separatorL = [CALayer layer];
        _separatorL.frame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 1.0f);
        _separatorL.backgroundColor = [UIColor darkGrayColor].CGColor;
        [tempV.layer addSublayer:_separatorL];
    }

    [tempV addSubview:label1];
    [tempV addSubview:label2];
    [tempV addSubview:label3];
    [tempV addSubview:iconImgV];
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
    
    int tempNum = (int)[[[self.aryGameIDs objectAtIndex:indexPath.section] objectForKey:@"game_name"] count];
    
//    NSLog(@"index.row==%d , tempNum==%d" , indexPath.row , tempNum);
    
    if (indexPath.row < tempNum) {
        GamesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GamesCell"];
        
        if(!cell) {
            cell = (GamesCell*)[[[NSBundle mainBundle] loadNibNamed:@"GamesCell" owner:nil options:nil] objectAtIndex:0];
        }
        
        [cell populateItem:[NSString stringWithFormat:@"%d" , (int)indexPath.row] gameTitle:[[[self.aryGameIDs objectAtIndex:indexPath.section] objectForKey:@"game_name"] objectAtIndex:indexPath.row] iconStr:nil rowId:indexPath.row colId:indexPath.section add:NO];
        
        cell.parentController = self;
        
        return cell;

    }else{
        AddGameCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddGameCell"];
        if (!cell) {
            cell = (AddGameCell*)[[[NSBundle mainBundle] loadNibNamed:@"AddGameCell" owner:nil options:nil] objectAtIndex:0];
        }
        
        [cell popularItem:@"Add Game" index:indexPath];
        cell.profile = self;
        
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return -1;
}

- (void) removeCellDataFromTable:(NSInteger) row column:(NSInteger)column{

    NSMutableDictionary* dict = [[self.aryGameIDs objectAtIndex:column] mutableCopy];
    NSMutableArray* ary = [NSMutableArray arrayWithArray:[dict objectForKey:@"game_name"]];
    [ary removeObjectAtIndex:row];
    
    [dict removeObjectForKey:@"game_name"];
    
    [dict setObject:ary forKey:@"game_name"];
   
    [self.aryGameIDs replaceObjectAtIndex:column withObject:dict];

    [[[GHUDataManager shared] gameidsList] removeAllObjects];
    [[[GHUDataManager shared] gameidsList] addObjectsFromArray:self.aryGameIDs];
    
   
    [self.contentTable reloadSections:[NSIndexSet indexSetWithIndex:column] withRowAnimation:UITableViewRowAnimationFade];
    

}
@end
