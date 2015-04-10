//
//  UIImage+ALExtended.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIImage (ALExtended)

- (UIImage*)fixOrientation;

- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end


