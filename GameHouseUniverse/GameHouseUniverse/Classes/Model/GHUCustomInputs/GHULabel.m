//
//  GHULabel.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHULabel.h"
#import "GHUSettingsManager.h"
#import "UIColor+ALExtended.h"

@implementation GHULabel

@synthesize originalColor;

-(void)dealloc{
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
- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
}

- (void)awakeFromNib {
    
	[super awakeFromNib];
	[self setup];
}

- (void)setup{
	
	if(self.tag > 0){
		NSArray* styles = [[GHUSettingsManager shared].settings objectForKey:@"TextStylesFont"];
		if(self.tag-1 < [styles count]){
			NSString* fontName = (NSString*)[styles objectAtIndex:self.tag-1];
			self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
		}
	}
	
	self.originalColor = self.textColor;
}

- (void)highlight:(BOOL)_highlight{
	self.textColor = _highlight ? [UIColor colorFromSettings:@"highlight"] : self.originalColor;
}

- (void)lowlight:(BOOL)_lowlight{
	self.textColor = _lowlight ? [UIColor colorFromSettings:@"lowlight"] : self.originalColor;
}

- (void)customlight:(BOOL)_customlight colorNameOrNil:(NSString *)_color{
	self.textColor = _customlight ? [UIColor colorFromSettings:_color] : self.originalColor;
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
