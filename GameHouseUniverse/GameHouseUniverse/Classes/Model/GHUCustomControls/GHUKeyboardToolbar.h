//
//  GHUKeyboardToolbar.m
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import "GHUToolbar.h"

@interface GHUKeyboardToolbar : GHUToolbar{
	UITextView* textView;
}

-(id)initWithFrame:(CGRect)frame textView:(UITextView*)_textView;
-(id)initStandardForTextView:(UITextView*)_textView;
-(void)didPressDismissKeyboardButton:(id)sender;

@property (nonatomic, retain) UITextView* textView;

@end
