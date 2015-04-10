//
//  GHUTextView.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUTextView.h"
#import "GHUSettingsManager.h"
#import "UIColor+ALExtended.h"

@implementation GHUTextView

@synthesize originalColor;

- (void)dealloc{
	self.originalColor = nil;
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
	
	[super awakeFromNib];
	
	if(self.tag > 0){
		NSArray* styles = [[GHUSettingsManager shared].settings objectForKey:@"TextStylesFont"];
		if(self.tag-1 < [styles count]){
			NSString* fontName = (NSString*)[styles objectAtIndex:self.tag-1];
			self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
		}
	}
	
	self.originalColor = self.textColor;
}
#pragma mark - IBAction SetUpk
-(IBAction)receiveFocus:(id)sender{
	[self becomeFirstResponder];
}

-(IBAction)looseFocus:(id)sender{
	if(self.superview && self.superview.subviews){
		for (UIView *childView in self.superview.subviews) {
			if ([childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder])
				[childView resignFirstResponder];
		}
	}
}

-(void)highlight:(BOOL)_highlight{
	
    self.textColor = _highlight ? [UIColor colorFromSettings:@"highlight"] : self.originalColor;
}

-(void)lowlight:(BOOL)_lowlight{
	self.textColor = _lowlight ? [UIColor colorFromSettings:@"lowlight"] : self.originalColor;
}

-(void)setText:(NSString *)text withPlaceholder:(NSString *)_placeholderOrNil{
	
	if(([text length] == 0 || !text) && _placeholderOrNil){
		[self lowlight:YES];
		[self setText:_placeholderOrNil];
	}
	else{
		[self lowlight:NO];
		[self setText:text];
	}	
}



@end
