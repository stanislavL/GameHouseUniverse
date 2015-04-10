//
//  StartViewController.h
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import <UIKit/UIKit.h>
#import "GHUScreenManager.h"
#import "GHULabel.h"
#import "GHUTextField.h"

@interface StartViewController : UIViewController{
    
    IBOutlet GHULabel* titleLabel;

    
}

@property (strong, nonatomic) IBOutlet GHULabel* titleLabel;
@end
