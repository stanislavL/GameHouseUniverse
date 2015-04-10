//
//  UIWebView+ALExtended.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "UIWebView+ALExtended.h"

@implementation UIWebView (ALExtended)

-(void)loadYoutubeURLString:(NSString *)_urlString{
	
	CGFloat width = self.frame.size.width;
	CGFloat height = self.frame.size.height;
	
	NSString* embedString = [NSString stringWithFormat:@"<html><head></head><body style=\"margin:0px; padding:0px;\"><iframe width=\"%0.0f\" height=\"%0.0f\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe></body></html>", width, height, _urlString];
	
	[self loadHTMLString:embedString baseURL:nil];
}

@end
