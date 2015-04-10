//
//  SignUpWIthPhotoViewController.m
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import "SignUpStepTwoViewController.h"
#import "GHUSessionManager.h"
#import "GHUApiRequest.h"
#import "GHUBarButtonItem.h"
#import "GHUAlertView.h"
#import "GHUScreenManager.h"
#import "UIColor+ALExtended.h"
#import "GHUAlertView.h"
#import "SignUpViewController.h"
#import "WelcomeViewController.h"
#import "TutorialViewController.h"
#import "AppDelegate.h"

@interface SignUpStepTwoViewController ()

@end

@implementation SignUpStepTwoViewController

@synthesize  password, passwordConfirm;
@synthesize delegate;
@synthesize backButton, finishButton;
@synthesize alertSignUp;
@synthesize userName = _userName, email = _email, imageData = _imageData;

- (void) dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.userName = nil;
    self.email = nil;
    self.imageData = nil;
    
    self.password = nil;
    self.passwordConfirm = nil;
    self.delegate = nil;
    self.backButton = nil;
    self.finishButton = nil;
    self.alertSignUp = nil;
    
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}
- (void) initWithUserName:(NSString*) name mailAddress:(NSString*) mailAddress imageData:(UIImage *)imageData {
    
    self.userName = name;
    self.email = mailAddress;
    if (imageData) {
        NSData *dataImage = [[NSData alloc] init];
        dataImage = UIImageJPEGRepresentation(imageData, 1);
        self.imageData = [dataImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }else{
        UIImage* img = [UIImage imageNamed:@"picture_bg.png"];
        NSData *dataImage = [[NSData alloc] init];
        dataImage = UIImagePNGRepresentation(img);
        self.imageData = [dataImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
    }
}
//======================================================================================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//======================================================================================================================================================================
- (BOOL) validateInput{

    if ([self.password.text length] == 0) {
   
         self.alertSignUp =[GHUAlertView alertWithTitle:NSLocalizedString(@"Password", nil) message:NSLocalizedString(@"Please enter an password for a SignUp." , nil) delegate:nil];
        return NO;
    }else if([self.passwordConfirm.text length] == 0){
        
         self.alertSignUp =[GHUAlertView alertWithTitle:NSLocalizedString(@"Confirm Password", nil) message:NSLocalizedString(@"Please Confirm an password for a SingnUp." , nil) delegate:nil];
        return NO;
    }if (![self.password.text isEqualToString:self.passwordConfirm.text]) {
       
        self.alertSignUp = [GHUAlertView alertWithTitle:NSLocalizedString(@"Invaild Password", nil) message:NSLocalizedString(@"Please Correctly  password for a SingnUp." , nil) delegate:nil];
        return NO;
    }
    return YES;
}


-(void)hideKeyboard{
	
    [self.password resignFirstResponder];
	[self.passwordConfirm resignFirstResponder];
    
}
//======================================================================================================================================================================
#pragma mark -
#pragma mark - Update Data
//======================================================================================================================================================================
- (void) updateData{
    
}
//======================================================================================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//======================================================================================================================================================================
- (IBAction)didPressBackButton:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)didPressFinishButton:(id)sender{
    
    [self hideKeyboard];
    [self initiateSignup];

}

- (void) initiateSignup{
    
    if (![self validateInput])
        return;
    
    [[GHUSessionManager shared] signUpWithEmail:self.userName email:self.email password:self.password.text image:self.imageData delegate:self success:@selector(signUpSucess:) failure:@selector(signUpFailed:)];
    
}
- (void) signUpSucess:(GHUApiRequest*)_request{
    
    GHUUserInfo* info   = [[GHUDataManager shared] userInfo];
    info.username       = self.userName;
    info.email          = self.email;
    info.pwd            = self.password.text;
    info.memberDate     = _request.createdDate;
    
    NSString* str = (NSString*)[_request.data objectForKey:@"profile_image"];
    if (str) {
        NSData* data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        UIImage* img = [UIImage imageWithData:data];
        UIImage * maskImage = [UIImage imageNamed:@"picture_bg.png"];
        UIImage * maskedImage = [self doImageMask:img withMask:maskImage];
        info.imageData = maskedImage;
    }
    
    [[GHUDefaultsManager shared] setUserInfo:info];
    [[GHUDefaultsManager shared] setProfileImage:info.imageData];
    [[GHUDataManager shared] setProfileRunning:NO];
    TutorialViewController* signUpVC = [[[TutorialViewController alloc] initWithNibName:[appDelegate getDeviceString:@"TutorialViewController"] bundle:nil] autorelease];
    [self.navigationController pushViewController:signUpVC animated:YES];
    
}
- (void) signUpFailed:(GHUApiRequest*)_request{
    
    if(_request.status == 900){
		
        //=========================================== Internet Connection Error ============================================
        self.alertSignUp = [GHUAlertView confirmWithTitle:NSLocalizedString(@"Internet connection",nil) message:NSLocalizedString(@"Your account could not be created because there is no connection to the Internet. Do you wish to cancel or try again?",nil) buttonLeft:NSLocalizedString(@"abort", nil) buttonRight:NSLocalizedString(@"Try again",nil) delegate:self];
	}
	
	else if(_request.status == 101){
		
		//=========================================== User data already exist ===============================================
		[GHUAlertView confirmWithTitle:NSLocalizedString(@"Users already registered",nil) message:[NSString stringWithFormat:NSLocalizedString(@"There is already an account for the input of your email address. Please log on via the normal login function",nil), _request.msg] buttonLeft:nil buttonRight:NSLocalizedString(@"OK",nil) delegate:self];
	}
	
    else if(_request.status == 200){
        //=================================================== Error ==========================================================
		self.alertSignUp = [GHUAlertView confirmWithTitle:NSLocalizedString(@"error",nil) message:[NSString stringWithFormat:NSLocalizedString(@"Your account could not be created because the GHU server reports an error (% @). Do you wish to cancel or try again?",nil), _request.msg] buttonLeft:NSLocalizedString(@"abort", nil) buttonRight:NSLocalizedString(@"try again",nil) delegate:self];
	}

    
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - UIAlertView Delegate
//======================================================================================================================================================================

- (void) alertView:(UIAlertView*) alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == self.alertSignUp) {
        if (buttonIndex == 0) {
            
        }else{
            [self initiateSignup];
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
