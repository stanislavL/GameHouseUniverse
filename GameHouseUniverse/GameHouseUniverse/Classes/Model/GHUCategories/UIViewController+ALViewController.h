//
//  UIViewController+ALViewController.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ALViewController)

-(void)iPadModalPresentationStyle:(UIModalPresentationStyle)_presentationStyle transitionStyle:(UIModalTransitionStyle)_transitionStyle;
-(void)iPadModalSize:(CGRect)_size;
-(void)ipadModalSizeGeneric;
-(BOOL)isModal;
-(void)dismissScreenAnimated:(BOOL)_animated;

@end
