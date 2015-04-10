//
//  GHUUserInfo.m
//  GameHouseUniverse
//
//  Created by stanislav on 17/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "GHUUserInfo.h"
#import "NSDictionary+ALExtended.h"

@implementation GHUUserInfo
@synthesize username,email,pwd;
@synthesize memberDate;
@synthesize imageData;


//===============================================================================================================
#pragma mark -
#pragma mark - dealloc Method
//===============================================================================================================
- (void) dealloc{
    
    self.username = nil;
    self.email = nil;
    self.pwd = nil;
    self.imageData = nil;

    
    
    [super dealloc];
}

- (GHUUserInfo *)copyWithZone:(NSZone *)zone {
    
    GHUUserInfo *info = [[GHUUserInfo allocWithZone:zone] init];
    
    info.username = self.username;
    info.pwd = self.pwd;
	info.email = self.email;
    info.memberDate = self.memberDate;
    info.imageData = self.imageData;

		
    return info;
}


//===============================================================================================================
#pragma mark -
#pragma mark//                                  Read From Dictionary
//===============================================================================================================

-(void)readDataFromDictionary:(NSDictionary*)data{
 
    self.username = [data stringForKey:@"username"];
    self.email = [data stringForKey:@"email"];
    self.pwd = [data stringForKey:@"pwd"];
    self.memberDate = [data stringForKey:@"date"];
    self.imageData = (UIImage*)[data objectForKey:@"profile_image"];
    
//    NSString* str = (NSString*)[data stringForKey:@"profile_image"];
//    if (str) {
//        NSData* data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        
//        UIImage* img = [UIImage imageWithData:data];
//        UIImage * maskImage = [UIImage imageNamed:@"picture_bg.png"];
//        UIImage * maskedImage = [self doImageMask:img withMask:maskImage];
//        self.imageData = maskedImage;
//    }
    


}
- (UIImage*) doImageMask:(UIImage *)mainImage withMask:(UIImage *)maskImage{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate(NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    
    
    if (mainViewContentContext == NULL){
        return NULL;
    }
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width/ mainImage.size.width;
    
    if(ratio * mainImage.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ mainImage.size.height;
    }
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {{-((mainImage.size.width*ratio)-maskImage.size.width)/2 , -((mainImage.size.height*ratio)-maskImage.size.height)/2}, {mainImage.size.width*ratio, mainImage.size.height*ratio}};
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, mainImage.CGImage);
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
    
    
}

@end
