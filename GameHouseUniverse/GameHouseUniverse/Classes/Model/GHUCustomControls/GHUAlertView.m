//
//  GHUAlertView.m
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//


#import "GHUAlertView.h"

@implementation GHUAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(UIAlertView*)alertWithTitle:(NSString *)_title message:(NSString *)_message delegate:(id)_delegate{
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:_title
													 message:_message
													delegate:_delegate
										   cancelButtonTitle:nil
										   otherButtonTitles:NSLocalizedString(@"OK", nil), nil] autorelease];
	[alert show];
	return alert;
}

+(UIAlertView*)confirmWithTitle:(NSString *)_title message:(NSString *)_message buttonLeft:(NSString *)_buttonLeft buttonRight:(NSString *)_buttonRight delegate:(id)_delegate	{
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:_title
													 message:_message
													delegate:_delegate
										   cancelButtonTitle:_buttonLeft
										   otherButtonTitles:_buttonRight,nil] autorelease];
	[alert show];
	return alert;
}


@end
