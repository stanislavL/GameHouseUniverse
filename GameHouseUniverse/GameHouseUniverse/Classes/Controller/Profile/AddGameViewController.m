//
//  AddGameViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 16/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "AddGameViewController.h"
#import "GamesCell.h"
#import "ProfileViewController.h"
@interface AddGameViewController ()

@end

@implementation AddGameViewController

@synthesize gametable;
@synthesize makerImg;
@synthesize gamerTagImage;
@synthesize gamerTagLabel;
@synthesize IdsTitle;
@synthesize searchField;
@synthesize tagName;
@synthesize aryGameNameList;

 
- (void) dealloc{
    NSLog(@"AddGameViewController dealloc");
    
  
    
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
    
    [self setUpElement];
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
- (void) openWithVC:(UIImage*) idImage idStr:(NSString*)idStr{
    
    self.makerImg = idImage;
    self.tagName = idStr;
}
//**********************************************************************************************************************************************
#pragma mark -
#pragma mark - Screen Operation
//**********************************************************************************************************************************************
- (void) setUpElement{
    
    self.gamerTagLabel.text = self.tagName;
    self.aryGameNameList = [[GHUDataManager shared] readFromGameList:self.tagName];

    if (self.makerImg) {
        [self.gamerTagImage setImage:self.makerImg];
  
    }else{
        [self.gamerTagImage setImage:[UIImage imageNamed:@"Icon_Battlenet_ID.png"]];
    }
    
}
- (void) updateElement{
    
    
}
//**********************************************************************************************************************************************
#pragma mark -
#pragma mark - IBAction SetUp
//**********************************************************************************************************************************************
- (IBAction)didPressBackBtn:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//**********************************************************************************************************************************************
#pragma mark -
#pragma mark - Custom SearchBar Delegate
//**********************************************************************************************************************************************
-(IBAction)searchFieldDidLooseFocus:(id)sender{
    [self.searchField resignFirstResponder];
    
    if([self.searchField.text length] > 0){
        [self startSearch];
    }
    else{
        [self endSearch];
    }
}
- (void) startSearch{
    
}
- (void) endSearch{
    
    
}

//**********************************************************************************************************************************************
#pragma mark -
#pragma mark - GamerTag TableViewController Delegate and DataSource

//**********************************************************************************************************************************************
//------------------ Section Height Setting
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}
//------------------ Section Count Setting
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//------------------ rows count Setting
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.aryGameNameList count] == 0) {
        return 0;
    }else{
        return  [self.aryGameNameList count];
    }
    
}
//------------------ rows Height Setting
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45.0f;
}

//------------------ Cell define
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GamesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GamesCell"];
    
    if(!cell) {
        cell = (GamesCell*)[[[NSBundle mainBundle] loadNibNamed:@"GamesCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    [cell populateItem:[NSString stringWithFormat:@"%d" , (int)indexPath.section] gameTitle:(NSString*)[self.aryGameNameList objectAtIndex:indexPath.row] iconStr:@"picture_bg" rowId:indexPath.row colId:indexPath.section add:YES];
    cell.addViewController = self;
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* gameName = [self.aryGameNameList objectAtIndex:indexPath.row];
    NSMutableArray* data = [[[GHUDataManager shared] gameidsList] mutableCopy];
   
    for (int i = 0; i< [data count]; i++) {
        
        NSMutableDictionary* dict = [[[data objectAtIndex:i] mutableCopy] autorelease];
        NSString* idsName  = [dict objectForKey:@"ids_name"];
        
        if ([idsName isEqualToString:self.tagName]) {
            
            
            NSMutableArray* arryGameName = [NSMutableArray arrayWithArray:[dict objectForKey:@"game_name"]];
            
            for (int j = 0; j< [arryGameName count]; j++) {
                NSString* str = (NSString*)[arryGameName objectAtIndex:j];
                if ([str isEqualToString:gameName]) {
                    [arryGameName removeObjectAtIndex:j];
                }
            }
            
            [arryGameName addObject:gameName];
            
            [dict removeObjectForKey:@"game_name"];
            
            [dict setObject:arryGameName forKey:@"game_name"];
        }
        [data replaceObjectAtIndex:i withObject:dict];
    }
    
    
    
    NSLog(@"data =%@" , data);
    NSLog(@"gameidlist==%@" , [[GHUDataManager shared] gameidsList]);
    
    
    [[[GHUDataManager shared] gameidsList] removeAllObjects];
    [[[GHUDataManager shared] gameidsList] addObjectsFromArray:data];
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    ProfileViewController* profileVC = [[[ProfileViewController alloc] initWithNibName:[appDelegate getDeviceString:@"ProfileViewController"] bundle:nil] autorelease];
//    [self.navigationController pushViewController:profileVC animated:YES];
    
}
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return -1;
}



@end
