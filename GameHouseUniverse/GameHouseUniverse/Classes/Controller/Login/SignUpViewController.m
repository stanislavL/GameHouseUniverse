//
//  SignUpViewController.m
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import "SignUpViewController.h"
#import "GHUSessionManager.h"
#import "GHUApiRequest.h"
#import "GHUBarButtonItem.h"
#import "GHUAlertView.h"
#import "GHUScreenManager.h"
#import "UIColor+ALExtended.h"
#import "GHUAlertView.h"
#import "SignUpStepTwoViewController.h"



@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize email,username;
@synthesize cancelButton, nextButton, addPictureButton;
@synthesize delegate;
@synthesize pickerImage;
@synthesize userNameFromFB;
@synthesize userProfileImage;

-(void)dealloc{
	
    self.pickerImage = nil;
    self.email = nil;
	self.username = nil;
	self.delegate = nil;
    self.userNameFromFB = nil;
	
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
- (void) setFromFBUserInfo:(NSString*) fbName fbImg:(UIImage *)fbImg{
    
    self.userNameFromFB = fbName;
    self.userProfileImage = fbImg;

}
- (void)viewDidLoad
{

    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self updateView];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - Operations
//======================================================================================================================================================================
- (void) updateView{
    
    if (self.userProfileImage) {

        [self.username setText:self.userNameFromFB];
        
        UIImage* origImage = self.userProfileImage;
        
        int topOffset = (origImage.size.height - origImage.size.width) / 2;
        CGRect cropRect = CGRectMake(0, topOffset, origImage.size.width, origImage.size.width);
        CGImageRef imageRef = CGImageCreateWithImageInRect(origImage.CGImage, cropRect);
        UIImage *cropImage = [UIImage imageWithCGImage:imageRef scale:origImage.scale orientation:origImage.imageOrientation];
        CGImageRelease(imageRef);
        
        UIImage * maskImage = [UIImage imageNamed:@"picture_bg.png"];
        UIImage * maskedImage = [self doImageMask:cropImage withMask:maskImage];
    
        [self.addPictureButton setImage:maskedImage forState:UIControlStateNormal];
    
    }else{
        
        [self.addPictureButton setImage:[UIImage imageNamed:@"addpicture_btn.png"] forState:UIControlStateNormal];
    }

}
-(void) hideKeyboard{
	
    [self.email resignFirstResponder];
	[self.username resignFirstResponder];
}


-(BOOL)validateInput{
	
	BOOL error = NO;
	
	if([self.email.text length] == 0){
		
		[GHUAlertView alertWithTitle:NSLocalizedString(@"No email address", nil) message:NSLocalizedString(@"Please enter a valid email address to which we will activate your account.", nil) delegate:nil];
		error = YES;
	
    }else if([self.username.text length] == 0){
		
		[GHUAlertView alertWithTitle:NSLocalizedString(@"No username", nil) message:NSLocalizedString(@"Please entry username.", nil) delegate:nil];
		error = YES;
	}
 
	return !error;
}


//======================================================================================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//======================================================================================================================================================================
- (IBAction)didPressCancelButton:(id)sender{
    
    [self hideKeyboard];
    [self cancelSignUp];
    
}
- (IBAction)didPressNextButton:(id)sender{
 
    [self hideKeyboard];
    [self initiateSignup];
    
}
- (IBAction)didPressAddPictureButton:(id)sender{
    
    NSLog(@"Add Picture Button clicked!");
   
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

- (void)initiateSignup{
    
	if(![self validateInput])
		return;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    SignUpStepTwoViewController* signUpVC = [[[SignUpStepTwoViewController alloc] initWithNibName:[appDelegate getDeviceString:@"SignUpStepTwoViewController"] bundle:nil] autorelease];
	[self.navigationController pushViewController:signUpVC animated:YES];
    [signUpVC initWithUserName:self.username.text mailAddress:self.email.text imageData:self.userProfileImage ];
    
}
- (void) cancelSignUp{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//======================================================================================================================================================================
#pragma mark - UIAlertView Delegate
//======================================================================================================================================================================
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

	if(alertView){
		if(buttonIndex == 1){
			[self initiateSignup];
		}

	}
}
//======================================================================================================================================================================
#pragma mark -
#pragma mark - UIImagePickerViewController delegate
//======================================================================================================================================================================
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * origImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

    UIImage* editImage = [[[UIImage alloc] init] autorelease];
    
    int topOffset = (origImage.size.height - origImage.size.width) / 2;
  
    CGFloat regularSize = 0.0f;
    

  
    if (topOffset > 0) {
        regularSize = origImage.size.width;
        editImage = [origImage imageRotatedByDegrees:90.0];

    }else{

        NSLog(@"imageOrientation==%ld" , origImage.imageOrientation);
        regularSize = origImage.size.width;
        
        if (origImage.imageOrientation == UIImageOrientationDown) {
            NSLog(@"UIImageOrientationDown");
            editImage = [origImage imageRotatedByDegrees:-180.0];
        }else if(origImage.imageOrientation == UIImageOrientationUp){
            NSLog(@"UIImageOrientationUp");
            editImage = [origImage imageRotatedByDegrees:0.0];
        
        }
        
   
    }
    
    CGRect cropRect = CGRectMake(0, topOffset, regularSize, regularSize);
    CGImageRef imageRef = CGImageCreateWithImageInRect(editImage.CGImage, cropRect);
    
    UIImage *cropImage = [UIImage imageWithCGImage:imageRef scale:origImage.scale orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    UIImage * maskImage = [UIImage imageNamed:@"picture_bg.png"];
    UIImage * maskedImage = [self doImageMask:cropImage withMask:maskImage];
   
    
   
    //Profile Image Setting
    [self.addPictureButton setImage:cropImage forState:UIControlStateNormal];
    self.userProfileImage = maskedImage;
    

}


- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
