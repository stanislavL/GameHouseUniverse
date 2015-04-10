//
//  AddIDView.h
//  GameHouseUniverse
//
//  Created by stanislav on 17/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUTextField.h"
#import "GHULabel.h"
#import "ProfileEditViewController.h"
#import "ProfileDetailsViewController.h"
#import "ProfileViewController.h"
#import "ProfileMenuViewController.h"
#import "GHUDialogView.h"
#import "ChooseIDView.h"
#import "GHUUserInfo.h"


@interface AddIDView : UIViewController<UIAlertViewDelegate>{
    
    IBOutlet UIButton* backBtn;
    IBOutlet UIButton* applyBtn;
    IBOutlet GHULabel* originName;
    IBOutlet GHUTextField* originTextFiled;
    IBOutlet GHUTextField* confirmTextFiled;
    IBOutlet UIImageView* originIDImage;
    
    
    GHUDialogView* pop;
    UIAlertView* alertAddID;
    NSString* originID;
    
}
@property (nonatomic, retain) NSString* gamerImageName;
@property (nonatomic, retain) GHUUserInfo* userInfo;
@property (nonatomic, retain) IBOutlet GHULabel* originName;
@property (nonatomic, retain) IBOutlet GHUTextField* originTextFiled;
@property (nonatomic, retain) IBOutlet GHUTextField* confirmTextFiled;

@property (nonatomic, retain) ChooseIDView* choosIDView;
@property (nonatomic, retain) NSString* originID;
@property (nonatomic, retain) GHUDialogView* pop;
@property (nonatomic, retain) ProfileEditViewController* profile;
@property (nonatomic, retain) UIAlertView* alertAddID;

- (void) resetData;
- (void) openWithVC:(NSString*) idType  image:(NSString*) image;
- (IBAction)didPressBackBtn:(id)sender;
- (IBAction)didPressApplyBtn:(id)sender;


@end
