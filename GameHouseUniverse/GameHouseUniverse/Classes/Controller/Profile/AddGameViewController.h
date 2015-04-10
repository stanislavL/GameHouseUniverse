//
//  AddGameViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 16/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUDataManager.h"
#import "GHUTable.h"
#import "GHUTextField.h"
#import "GHUApiRequest.h"
#import "GHUDefaultsManager.h"
#import "GHUGameIDs.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUScrollView.h"
#import "GamesCell.h"

@interface AddGameViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>{
    
    
    
    
}

@property (nonatomic, retain) NSMutableArray* aryGameNameList;
@property (nonatomic, retain) UIImage* makerImg;
@property (nonatomic, retain) GHUGameIDs* IdsTitle;
@property (nonatomic, strong) IBOutlet UITableView* gametable;
@property (nonatomic, strong) IBOutlet UIImageView* gamerTagImage;
@property (nonatomic, strong) IBOutlet GHUTextField* searchField;
@property (nonatomic, strong) IBOutlet GHULabel* gamerTagLabel;
@property (nonatomic, retain) NSString* tagName;
@property (nonatomic, assign) BOOL editViewEnable;

- (void) setUpElement;
- (void) updateElement;

- (void) openWithVC:(UIImage*) idImage idStr:(NSString*)idStr;
-(IBAction)searchFieldDidLooseFocus:(id)sender;

@end
