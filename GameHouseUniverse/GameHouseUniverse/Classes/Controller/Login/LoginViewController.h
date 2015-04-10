//
//  LoginViewController.h
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import "StartViewController.h"
#import "GHUApiRequest.h"
#import "GHUTextField.h"
#import "GHULabel.h"
#import "AppDelegate.h"
#import "GHUScreenManager.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate , UIActionSheetDelegate,FBLoginViewDelegate>{
    
    IBOutlet GHUTextField* email;
    IBOutlet GHUTextField* password;
    
    IBOutlet UIButton* loginButton;
    IBOutlet UIButton* registerButton;
    IBOutlet UIButton* registerWithFBButton;
    
    IBOutlet UIImageView* ghuMarkImage;
    IBOutlet UIImageView* ghuTitleImage;
 
    
    
    AppDelegate* appDelegate;
    UIAlertView* alertSignIn;
    
}

@property(nonatomic, retain) IBOutlet GHUTextField* email;
@property(nonatomic, retain) IBOutlet GHUTextField* password;
@property(nonatomic, retain) IBOutlet UIButton* loginButton;
@property(nonatomic, retain) IBOutlet UIButton* registerButton;
@property(nonatomic, retain) IBOutlet UIButton* registerWithFBButton;
@property(nonatomic, retain) UIAlertView* alertSignIn;

@property (strong, nonatomic) NSArray* dataInfo;
@property (strong, nonatomic) NSArray* dataInfo1;
@property (nonatomic, retain) NSString* fbUserName;
@property (nonatomic, retain) UIImage* fbUserImg;
@property(nonatomic, strong) IBOutlet FBProfilePictureView* fbPictureView;

 



- (BOOL) validateInput;
- (void) initiateLogin;
- (void) initiateSignUp;
- (void) initWithFBSignUp;
- (void) updateView;

- (void) loginSuccess:(GHUApiRequest*) _request;
- (void) loginFailure:(GHUApiRequest*) _request;


- (IBAction)didPressLoginButton:(id)sender;
- (IBAction)didPressRegisterButton:(id)sender;
- (IBAction)didPressRegisterWithFBButton:(id)sender;
- (UIImage*) doImageMask:(UIImage *)mainImage withMask:(UIImage *)maskImage;

@end
