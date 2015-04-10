//
//  GHUTextField.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//
#import "GHUTextField.h"
#import "GHUSettingsManager.h"

@implementation GHUTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(IBAction)receiveFocus:(id)sender{
	if([self respondsToSelector:@selector(becomeFirstResponder)])
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

- (void)awakeFromNib {
    
	[super awakeFromNib];
	
	if(self.tag > 0){
		NSArray* styles = [[GHUSettingsManager shared].settings objectForKey:@"TextStylesFont"];
		if(self.tag-1 < [styles count]){
			NSString* fontName = (NSString*)[styles objectAtIndex:self.tag-1];
			self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
		}
	}
	
}

@end
