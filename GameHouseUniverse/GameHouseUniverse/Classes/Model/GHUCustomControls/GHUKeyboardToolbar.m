//
//  GHUKeyboardToolbar.m
//  Game Hours Universe
//
//  Created by stanislav on 09/10/14.
//
//

#import "GHUKeyboardToolbar.h"
#import "GHUBarButtonItem.h"

@implementation GHUKeyboardToolbar

@synthesize textView;

-(void)dealloc{
	self.textView = nil;
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setupTextViewAccessoryView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame textView:(UITextView*)_textView{
	self = [super initWithFrame:frame];
	
	if(self){
		self.textView = _textView;
		[self setupTextViewAccessoryView];
	}
	return self;
}

-(id)initStandardForTextView:(UITextView *)_textView{
	
	return [self initWithFrame:CGRectMake(0,0,320, 44) textView:_textView];

}

- (void)setupTextViewAccessoryView{
	
	UIBarButtonItem* button1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	GHUBarButtonItem* button2 = [[GHUBarButtonItem alloc] initWithImageNamed:@"picker_navbar_button_fertig.png" imageHighlightedNamed:@"picker_navbar_button_fertig_pressed.png" target:self selector:@selector(didPressDismissKeyboardButton:)];
	
	[self setItems:[NSArray arrayWithObjects: button1, button2, nil] animated:NO];
}

-(void)didPressDismissKeyboardButton:(id)sender{
	[self.textView resignFirstResponder];
}

@end
