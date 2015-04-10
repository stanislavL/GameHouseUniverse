//
//  LoadingViewController.h
//  GameHouseUniverse
//
//  Created by stanislav on 10/11/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController{
    
    IBOutlet UIActivityIndicatorView* activity;
    BOOL enableVC;
    
}
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activity;

- (void) didReceiveDataLoadedNotification:(NSNotification*) _notification;
- (void) didReceiveSignUpNotification:(NSNotification*) _notification;
@end
