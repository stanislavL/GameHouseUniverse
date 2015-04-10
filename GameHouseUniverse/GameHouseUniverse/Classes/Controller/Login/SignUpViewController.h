//
//  SignUpViewController.h
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import <UIKit/UIKit.h>
#import "GHUNavigationBar.h"
#import "GHUTextField.h"
#import "GHULabel.h"
#import "LoginViewController.h"
#import "SignUpStepTwoViewController.h"
#import "GHUScreenManager.h"
#import "UIImage+ALExtended.h"
#import <FacebookSDK/FacebookSDK.h>

@interface SignUpViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    IBOutlet GHUTextField* email;
	IBOutlet GHUTextField* username;

    
    IBOutlet UIButton* cancelButton;
    IBOutlet UIButton* nextButton;
    IBOutlet UIButton* addPictureButton;
    IBOutlet UIImageView* pickerImage;
    
    id delegate;

}

@property(nonatomic, retain) IBOutlet GHUTextField* email;
@property(nonatomic, retain) IBOutlet GHUTextField* username;
@property(nonatomic, retain) NSString* userNameFromFB;
@property(nonatomic, retain) UIImage*  userProfileImage;

@property(nonatomic, retain) IBOutlet UIButton* cancelButton;
@property(nonatomic, retain) IBOutlet UIButton* nextButton;
@property(nonatomic, retain) IBOutlet UIButton* addPictureButton;
@property(nonatomic, retain) IBOutlet UIImageView* pickerImage;

@property (nonatomic, retain) id delegate;

- (IBAction)didPressCancelButton:(id)sender;
- (IBAction)didPressNextButton:(id)sender;
- (IBAction)didPressAddPictureButton:(id)sender;

- (void) updateView;
- (BOOL) validateInput;
- (void) cancelSignUp;
- (void) initiateSignup;
- (void) setFromFBUserInfo:(NSString*) fbName fbImg:(UIImage*) fbImg;
- (UIImage*) doImageMask:(UIImage *)mainImage withMask:(UIImage *)maskImage;

@end
