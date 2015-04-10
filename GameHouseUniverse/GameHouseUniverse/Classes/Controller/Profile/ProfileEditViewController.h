//
//  ProfileEditViewController.h
//  GameHouseUniverse
//
//  Created by Admin on 1/27/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "GHUUserInfo.h"
#import "AppDelegate.h"
#import "AddGameCell.h"

@interface ProfileEditViewController : UIViewController <UIApplicationDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    AppDelegate* appDelegate;
    BOOL dialogEnable;
    
}
@property(nonatomic, assign) BOOL addNewGameEnable;
@property(nonatomic, strong) IBOutlet UITableView* contentTable;
@property(nonatomic, strong) IBOutlet UIImageView* profileImage;

@property(nonatomic, assign) NSMutableArray* aryGameIDs;
@property(nonatomic, strong) NSMutableArray *treeOpenArray;

@property(nonatomic, strong) NSString *treeOpenString;
@property(nonatomic, retain) GHUUserInfo* userInfo;
@property(nonatomic, retain) GHUGameIDs* profile;

- (void) openWithVC:(BOOL) enableDialog;
- (void) moveToProfileView:(GHUUserInfo*) userInfo;
- (void) moveToAddGameView:(NSIndexPath*) index;
- (void) setUpElement;
- (void) updateElement;
- (void) addSelectGameIDView;
- (void) tapAction:(UIButton *)sender;
- (void) saveData;
- (void) removeCellDataFromTable:(NSInteger) row column:(NSInteger)column;

@end
