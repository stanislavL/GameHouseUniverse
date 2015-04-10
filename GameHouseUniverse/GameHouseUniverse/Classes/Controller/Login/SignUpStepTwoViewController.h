//
//  SignUpWIthPhotoViewController.h
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "GHUNavigationBar.h"
#import "GHUTextField.h"
#import "GHULabel.h"
#import "LoginViewController.h"
#import "GHUScreenManager.h"
#import "GHUGameIDs.h"
#import "GHUUserInfo.h"
#import <Parse/Parse.h>
#import <stdlib.h>

@interface SignUpStepTwoViewController : UIViewController<UIAlertViewDelegate , UITextFieldDelegate>{
    
    IBOutlet GHUTextField* password;
	IBOutlet GHUTextField* passwordConfirm;
    
    IBOutlet UIButton* backButton;
    IBOutlet UIButton* finishButton;
    
    UIImage* _profileImage;
    NSString* _userName;
    NSString* _email;
    NSString* _imageData;
    id deldgate;
    UIAlertView* alertSignUp;
    AppDelegate* appDelegate;
    
}


@property(nonatomic, retain) IBOutlet GHUTextField* password;
@property(nonatomic, retain) IBOutlet GHUTextField* passwordConfirm;
@property(nonatomic, retain) IBOutlet UIButton* backButton;
@property(nonatomic, retain) IBOutlet UIButton* finishButton;
@property(nonatomic, retain) UIAlertView* alertSignUp;

@property (nonatomic, retain) NSString* userName;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) UIImage* profileImage;
@property (nonatomic, retain) NSString* imageData;;
@property(nonatomic, retain) id delegate;


- (IBAction)didPressBackButton:(id)sender;
- (IBAction)didPressFinishButton:(id)sender;
- (void) initiateSignup;

- (void) updateData;
- (void) initWithUserName:(NSString*) name mailAddress:(NSString*) mailAddress imageData:(UIImage *)imageData;
- (UIImage*) doImageMask:(UIImage *)mainImage withMask:(UIImage *)maskImage;

@end
