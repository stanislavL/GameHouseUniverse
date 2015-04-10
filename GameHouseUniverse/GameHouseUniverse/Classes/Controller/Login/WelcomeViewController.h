//
//  WelcomeViewController.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <UIKit/UIKit.h>
#import "GHUScreenManager.h"
#import "GHULabel.h"
#import "GHUTextField.h"
#import "GHUToolbar.h"
#import "SignUpStepTwoViewController.h"
#import "GHUUserInfo.h"

@interface WelcomeViewController : UIViewController{
    
    IBOutlet GHULabel* userName;
    GHUUserInfo* user;
}
@property (nonatomic, retain) IBOutlet GHULabel* userName;
@property (nonatomic, retain) GHUUserInfo* user;

- (void) openVC:(GHUUserInfo*) _user;
- (void) setUpElement;
- (void) onProfile:(NSTimer*) timer;
@end

