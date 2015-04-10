//
//  ChooseIDView.h
//  GameHouseUniverse
//
//  Created by stanislav on 14/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUDialogView.h"
#import "AppDelegate.h"


@class ProfileEditViewController;
@interface ChooseIDView : UIViewController{
    
    NSMutableArray* aryBtns;
    NSMutableArray* aryIDs;
    NSMutableArray* aryImages;
    GHUDialogView* pop;
    
    ProfileEditViewController* profile;
    AppDelegate* appDelegate;
    
    int selectedID;
    
    IBOutlet UIButton* backBtn;
}
@property (nonatomic, retain) NSMutableArray* aryBtns;
@property (nonatomic, retain) NSMutableArray* aryIDs;
@property (nonatomic, retain) NSMutableArray* aryImages;
@property (nonatomic, retain) GHUDialogView* pop;
@property (nonatomic, retain) ProfileEditViewController* profile;

- (IBAction)didPressBackBtn:(id)sender;
- (void) initWithData;
- (void) initWithView;
- (void) enableView;

@end
