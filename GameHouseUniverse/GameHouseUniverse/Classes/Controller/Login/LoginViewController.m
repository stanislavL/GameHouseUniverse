//
//  LoginViewController.m
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import "LoginViewController.h"
#import "GHUAlertView.h"
#import "GHUApiRequest.h"
#import "GHUSessionManager.h"
#import "AppDelegate.h"
#import "GHUDataManager.h"
#import "GHUTextField.h"
#import "GHULabel.h"
#import "SignUpViewController.h"
#import "UIViewController+ALViewController.h"
#import "GHUSettingsManager.h"
#import "UIColor+ALExtended.h"
#import "ProfileViewController.h"
#import "JSONKit.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize email;
@synthesize password;
@synthesize loginButton, registerButton, registerWithFBButton;
@synthesize alertSignIn;
@synthesize dataInfo;
@synthesize dataInfo1;
@synthesize fbUserName;

//@synthesize fbProfilePicture;

- (void) dealloc{

    NSLog(@"LoginViewConttoller dealloc");
    
    self.email = nil;
    self.password = nil;
    self.loginButton = nil;
    self.registerButton = nil;
    self.registerWithFBButton = nil;
    self.fbUserName = nil;
    
    
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.email.textColor = [UIColor colorFromSettings:@"email"];
    self.password.textColor = [UIColor colorFromSettings:@"password"];

 
    
}

- (void) updateView{
    
    if ([[FBSession activeSession]isOpen]) {
        [[FBRequest requestForMe]startWithCompletionHandler:
         ^(FBRequestConnection* conn,
           NSDictionary<FBGraphUser>* user,
           NSError* error){
             if (!error) {
                 self.fbUserName= user.name;
                 self.fbPictureView.profileID = user.id;
                 
                 // Convert to UIImage from FBPrfileImage
                 CGSize imageSize = self.fbPictureView.frame.size;
                 UIGraphicsBeginImageContext(imageSize);
                 CGContextRef imageContext = UIGraphicsGetCurrentContext();
                 
                 [self.fbPictureView.layer renderInContext: imageContext];
                 UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
                 
                 self.fbUserImg = viewImage;
                 
                 NSLog(@"FBUserName =%@" , user.name);
                 NSLog(@"FBUserProfilePicture =%@" , user.id);
                 
                 [self performSelector:@selector(getUserImageFromFBView) withObject:nil afterDelay:2.0];
                 
                 
                 
             }
         }];
    }

    
}
- (void) getUserImageFromFBView{
    
    [self hideKeyboard];
    [self initiateSignUp];
}
- (void) viewDidUnload{
    
    [super viewDidUnload];
}
- (void) viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    if ([[FBSession activeSession]isOpen]) {
        
        NSString* qry=@"SELECT uid, name, pic_square FROM user where uid in (SELECT uid2 FROM friend where uid1=me())";
        [self fql:qry];
        
        NSString* qry1=@"SELECT  message from status where uid=me() ";
        [self fql1:qry1];
    }

}


- (void) viewWillDisappear:(BOOL)animated{
   
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//======================================================================================================================================================================
- (IBAction)didPressLoginButton:(id)sender{
    
    [self hideKeyboard];
	[self initiateLogin];
    
}
- (IBAction)didPressRegisterButton:(id)sender{
    
    [self hideKeyboard];
	[self initiateSignUp];
    
}
- (IBAction)didPressRegisterWithFBButton:(id)sender{
    
    [self hideKeyboard];
    [self initWithFBSignUp];
}
//======================================================================================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//======================================================================================================================================================================
-(void)dismissScreenAnimated:(BOOL)_animated{
	
    [self.navigationController popViewControllerAnimated:_animated];
}
- (BOOL) validateInput{
    
    if ([self.email.text length] == 0) {
        
        [GHUAlertView alertWithTitle:NSLocalizedString(@"Email Address", nil) message:NSLocalizedString(@"Please enter an email address for a login." , nil) delegate:nil];
        return NO;
   
    }else if([self.password.text length] == 0){
      
        [GHUAlertView alertWithTitle:NSLocalizedString(@"Password ", nil) message:NSLocalizedString(@"Please enter an password for a login." , nil) delegate:nil];
        return NO;
    }
    
    return YES;
}
-(void)hideKeyboard{
	
    [self.email resignFirstResponder];
	[self.password resignFirstResponder];
    
}
//======================================================================================================================================================================
#pragma mark - 
#pragma mark - Login/SignUp Modules SetUp
//======================================================================================================================================================================
- (void) initiateSignUp{
	
	SignUpViewController* signUpVC = [[[SignUpViewController alloc] initWithNibName:[appDelegate getDeviceString:@"SignUpViewController"] bundle:nil] autorelease];
    [signUpVC setFromFBUserInfo:self.fbUserName fbImg:self.fbUserImg];
    [self.navigationController pushViewController:signUpVC animated:YES];
    
	
}
- (void) initWithFBSignUp{
    
    NSArray* permissions = [[NSArray alloc] initWithObjects:@"read_stream",@"user_likes", nil];
    [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        switch (status) {
            case FBSessionStateOpen:
                NSLog(@"SessionStateOpen");
                [self updateView];
                break;
            case FBSessionStateCreated:
                NSLog(@"SessionStateCreated");
                break;
           case FBSessionStateClosedLoginFailed:
                NSLog(@"SessionStateClosed");
                [[FBSession activeSession] closeAndClearTokenInformation];
                
            default:
                break;
        }
    }];
    
 
}
- (void) initiateLogin{
    
    if (![self validateInput])
        return;
    
    [[GHUSessionManager shared] loginWithEmail:self.email.text password:self.password.text delegate:self success:@selector(loginSuccess:) failure:@selector(loginFailure:)];
}
- (void) loginSuccess:(GHUApiRequest*) _request{
    
    GHUUserInfo* userInfo = [[GHUDataManager shared] userInfo];
    userInfo.username = _request.userID;
    userInfo.memberDate = _request.createdDate;
    userInfo.email = self.email.text;
    userInfo.pwd = self.password.text;
    
    NSString* str = (NSString*)[_request.data objectForKey:@"profile_image"];
    if (str) {
        NSData* data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        UIImage* img = [UIImage imageWithData:data];
        UIImage * maskImage = [UIImage imageNamed:@"picture_bg.png"];
        UIImage * maskedImage = [self doImageMask:img withMask:maskImage];
        userInfo.imageData = maskedImage;
    }
 
    [[GHUDefaultsManager shared] setUserInfo:userInfo];
    [[GHUDefaultsManager shared] setProfileImage:userInfo.imageData];
  
    //--Profile Data Loading------
//    [[GHUDataManager shared] profileReadDetailsForProfile:@"profile" delegate:self success:@selector(profileSuccess:) failure:@selector(ProfileFailes:)];
 
}
- (void) loginFailure:(GHUApiRequest*) _request{
 
    if(_request.status == 900){
		
		// Connection Error
		self.alertSignIn = [GHUAlertView confirmWithTitle:NSLocalizedString(@"Internet connection",nil) message:NSLocalizedString(@"Unfortunately, the login could not be performed because there is no connection to the Internet. Do you wish to cancel or try again?",nil) buttonLeft:NSLocalizedString(@"Abort", nil) buttonRight:NSLocalizedString(@"Try again",nil) delegate:self];
	}
	
	else if(_request.status == 101){
		// Incorrect user data
		[GHUAlertView confirmWithTitle:NSLocalizedString(@"Unknown user data",nil) message:[NSString stringWithFormat:NSLocalizedString(@"The one given by you combination of email and password unfortunately is unknown or incorrect. Please controlling your entry and try again.",nil), _request.msg] buttonLeft:nil buttonRight:NSLocalizedString(@"Eingaben kontrollieren",nil) delegate:self];
	}
	else if(_request.status == 200){
		
        [GHUAlertView confirmWithTitle:NSLocalizedString(@"Error",nil) message:[NSString stringWithFormat:NSLocalizedString(@"Registration is unfortunately failed because the GHU server reports an error (% @). Please check it, your input and try again.",nil), _request.msg] buttonLeft:nil buttonRight:NSLocalizedString(@"Next",nil) delegate:self];
	}
	
	else if(_request.status == 400){
		
        [GHUAlertView confirmWithTitle:NSLocalizedString(@"No authorization",nil) message:[NSString stringWithFormat:NSLocalizedString(@"Unfortunately you do not have permission to log on using this account on the mobile app.",nil), _request.msg] buttonLeft:nil buttonRight:NSLocalizedString(@"OK",nil) delegate:self];
	}
	
	else if(_request.status == 401){
	
        [GHUAlertView confirmWithTitle:NSLocalizedString(@"No authorization",nil) message:[NSString stringWithFormat:NSLocalizedString(@"You have not properly licensed, to login using your GHU account in this app. Please buckle from a suitable package under www.ghu.com and try again.",nil)] buttonLeft:nil buttonRight:NSLocalizedString(@"OK",nil) delegate:self];
	}
    
}

//-(void) profileSuccess:(GHUApiRequest*)_request{
//    
//    
////    NSString* jsonString = (NSString*)[_request.data objectForKey:@"data"];
////    
////    NSLog(@"string==%@" , jsonString);
////    
////    [[GHUDataManager shared] setProfileRunning:YES];
////    NSData * jsonData = [jsonString dataUsingEncoding:nil];
////    NSError * error = nil;
////    NSMutableArray * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
////    [[[GHUDataManager shared] gameidsList] addObjectsFromArray:parsedData];
//
//
//
//
//    
//}
//-(void) ProfileFailes:(GHUApiRequest*)_request{
//    
//}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - Facebook method define
//======================================================================================================================================================================
- (void) fql:(NSString*)query
{
    if ([[FBSession activeSession]isOpen ]) {
        
        //        NSString* query=@"{"
        //        @"'friends':'SELECT uid,name,pic_square FROM user where uid IN (SELECT uid2 FROM friend where uid1=me())',"
        //        @"'status':'Select message from status where uid in(SELECT uid from #friends)',"
        //        @"}";
        
        NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:query,@"q",nil];
        
        [FBRequestConnection startWithGraphPath:@"/fql" parameters:param HTTPMethod:@"GET" completionHandler:^(FBRequestConnection* connection,
                                                                                                               id result,
                                                                                                               NSError* error){
            if (error) {
                NSLog(@"Error: %@",[error localizedDescription]);
            } else {
                NSLog(@"Result: %@", result);
                dataInfo=[result objectForKey:@"data"];
            }
        }];
        
    }
}

- (void) fql1:(NSString*)query
{
    if ([[FBSession activeSession]isOpen ]) {
        NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:query,@"q",nil];
        [FBRequestConnection startWithGraphPath:@"/fql" parameters:param HTTPMethod:@"GET" completionHandler:^(FBRequestConnection* connection,
                                                                                                               id result,
                                                                                                               NSError* error){
            if (error) {
                NSLog(@"Error: %@",[error localizedDescription]);
            } else {
                NSLog(@"Result: %@", result);
                dataInfo1=[result objectForKey:@"data"];
            }
        }];
    }
}


//======================================================================================================================================================================
#pragma mark -
#pragma mark - UIAlertView Delegate
//======================================================================================================================================================================
- (void) alertView:(UIAlertView*) alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == self.alertSignIn) {
        if (buttonIndex == 0) {
            
        }else{
            [self initiateLogin];
        }
    }
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

@end

