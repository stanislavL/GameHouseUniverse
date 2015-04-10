//
//  GHUNavigationBar.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <UIKit/UIKit.h>

@interface GHUNavigationBar : UINavigationBar {
	id delegate;
}

-(void)initALElements;

@property (nonatomic, assign) id delegate;

@end
