//
//  GHUAlertView.h
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import <UIKit/UIKit.h>

@interface GHUAlertView : UIAlertView

+(UIAlertView*)alertWithTitle:(NSString *)_title message:(NSString *)_message delegate:(id)_delegate;
+(UIAlertView*)confirmWithTitle:(NSString *)_title message:(NSString *)_message buttonLeft:(NSString *)_buttonLeft buttonRight:(NSString *)_buttonRight delegate:(id)_delegate;

@end
