//
//  PostView.m
//  GameHouseUniverse
//
//  Created by stanislav on 02/12/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "PostView.h"

@implementation PostView
@synthesize teamName, communitiesName;
@synthesize alertSignIn;
@synthesize feed;

- (void) dealloc{
    
    self.teamName = nil;
    self.communitiesName = nil;
    
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView* bg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 122.0f)];
        bg.image = [UIImage imageNamed:@"button_back_image.png"];
        [self addSubview:bg];
    }
    return self;
}

+ (id) postView{
    
    PostView* customView = [[[NSBundle mainBundle] loadNibNamed:@"PostView" owner:nil options:nil] lastObject];
    if ([customView isKindOfClass:[PostView class]]) {
        return customView;
    }else{
        return nil;
    }
}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//======================================================================================================================================================================
- (void) setUpElement{
    
    
}
- (void) updateElement{
    
    
}
- (BOOL) validateInput{
    
    if ([self.teamName.text length] == 0) {
        
        [GHUAlertView alertWithTitle:NSLocalizedString(@"TeamName", nil) message:NSLocalizedString(@"Please enter an team name to post." , nil) delegate:nil];
        return NO;
        
    }else if([self.communitiesName.text length] == 0){
        
        [GHUAlertView alertWithTitle:NSLocalizedString(@"Password ", nil) message:NSLocalizedString(@"Please enter an community name to post." , nil) delegate:nil];
        return NO;
    }
    
    return YES;
}
-(void)hideKeyboard{
	
    [self.teamName resignFirstResponder];
	[self.communitiesName resignFirstResponder];
    
}

- (IBAction)didPressCancelBtn:(id)sender{
    
    NSLog(@"Pressed Cancel Button");

    [self hideKeyboard];
    [self.feed showPostView:NO];
    [self setUpElement];

}
- (IBAction)didPressCreateBtn:(id)sender{
    
    NSLog(@"Pressed Create Button");
    
    if (![self validateInput])
        return;
    
    [self hideKeyboard];
    [self.feed showPostView:NO];
    [self setUpElement];

}

//======================================================================================================================================================================
#pragma mark -
#pragma mark - UIAlertView Delegate
//======================================================================================================================================================================
- (void) alertView:(UIAlertView*) alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == self.alertSignIn) {
        if (buttonIndex == 0) {
            
        }else{
            
        }
    }
}

@end
