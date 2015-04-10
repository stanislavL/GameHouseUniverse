//
//  GHULabel.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <UIKit/UIKit.h>

@interface GHULabel : UILabel{
	UIColor* originalColor;
}

-(void)setup;
-(void)highlight:(BOOL)_highlight;
-(void)lowlight:(BOOL)_lowlight;
-(void)customlight:(BOOL)_customlight colorNameOrNil:(NSString*)_color;
-(void)setText:(NSString *)_text withPlaceholder:(NSString*)_placeholderOrNil;

@property (nonatomic, retain) UIColor* originalColor;

@end
