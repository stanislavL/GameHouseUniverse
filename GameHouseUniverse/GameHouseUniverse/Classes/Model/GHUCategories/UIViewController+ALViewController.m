//
//  UIViewController+ALViewController.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "UIViewController+ALViewController.h"
#import "GHUScreenManager.h"

@implementation UIViewController (GHUViewController)

-(void)iPadModalPresentationStyle:(UIModalPresentationStyle)_presentationStyle transitionStyle:(UIModalTransitionStyle)_transitionStyle{
	
	if([GHUScreenManager isIPad]){
		self.modalPresentationStyle = _presentationStyle;
		self.modalTransitionStyle = _transitionStyle;
	}
}

-(void)iPadModalSize:(CGRect)_size{
	
	if([GHUScreenManager isIPad]){
		self.view.superview.bounds = _size;
		//self.view.superview.center = self.view.center;
		//self.view.bounds = _size;
		//self.view.superview.bounds = _size;
		//self.view.superview.bounds = CGRectMake(0,0,100, 200);
		//self.view.superview.center = CGPointMake(300, 300);
	}
}

-(void)ipadModalSizeGeneric{
	[self iPadModalSize:CGRectMake(0, 0, 320, 548)];
}

-(BOOL)isModal {
	
	BOOL isModal = ((self.parentViewController && self.parentViewController.presentedViewController == self) ||
					//or if I have a navigation controller, check if its parent modal view controller is self navigation controller
					( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.presentedViewController == self.navigationController) ||
					//or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
					[[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
	
    //iOS 5+
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
		
        isModal = ((self.presentingViewController && self.presentingViewController.presentedViewController == self) ||
				   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
				   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.presentedViewController == self.navigationController) ||
				   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
				   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
		
    }
	
    return isModal;        
	
}

-(void)dismissScreenAnimated:(BOOL)_animated{
	
	if([self isModal]){
		[self dismissViewControllerAnimated:_animated completion:nil];
	}
	else{
		if(self.navigationController && [self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)])
		   [self.navigationController popViewControllerAnimated:_animated];
	}
}


@end
