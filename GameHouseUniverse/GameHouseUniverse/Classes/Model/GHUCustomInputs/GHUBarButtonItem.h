//
//  GHUBarButtonItem.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <UIKit/UIKit.h>

@interface GHUBarButtonItem : UIBarButtonItem{
}

-(id)initWithImageNamed:(NSString*)_imageName imageHighlightedNamed:(NSString*)_imageHighlightedName target:(id)_target selector:(SEL)_selector;

-(id)initWithImageNamed:(NSString*)_imageName imageHighlightedNamed:(NSString*)_imageHighlightedName title:(NSString*)_title target:(id)_target selector:(SEL)_selector;

@end














