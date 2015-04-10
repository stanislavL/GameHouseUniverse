//
//  GHUViewController.h
//  Game Hours Universe
//
//  Created by stanislav on 12/10/14.
//
//

#import <UIKit/UIKit.h>

@interface GHUViewController : UIViewController{
    
    UIViewController* activeViewController;
}

@property (nonatomic, strong) UIViewController * activeViewController;

- (void) setupElements;


@end
