//
//  GHUTextView.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <SSToolkit/SSToolkit.h>

@interface GHUTextView : SSTextView{
	
    UIColor* originalColor;
}

-(IBAction)receiveFocus:(id)sender;
-(IBAction)looseFocus:(id)sender;

-(void)highlight:(BOOL)_highlight;
-(void)lowlight:(BOOL)_lowlight;
-(void)setText:(NSString *)_text withPlaceholder:(NSString*)_placeholderOrNil;

@property (nonatomic, retain) UIColor* originalColor;

@end
