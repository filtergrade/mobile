//
//  FGGradientHelper.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/4/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGGradientHelper.h"

// Degrees to radians
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation FGGradientHelper

// TODO: Add params for origin, scale, radial/linear, start color, end color,

+ (UIImage*) createLinearGradientWithOrigin:(CGPoint)origin
                                    inFrame:(CGRect)frame
                                    atScale:(CGFloat)atScale
                                 angleInDeg:(CGFloat)angleInDeg
                                 startColor:(UIColor*)startColor
                                   endColor:(UIColor*)endColor
{
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, NULL);
    
    CGFloat angle = DEGREES_TO_RADIANS(angleInDeg);
    
    CGFloat radius = atScale * MIN(frame.size.width, frame.size.height);
    
    CGPoint start = CGPointMake(origin.x - (radius * cosf(angle)), origin.y + (radius * sinf(angle)));
    CGPoint end   = CGPointMake(origin.x + (radius * cosf(angle)), origin.y - (radius * sinf(angle)));
    
    // Apply gradient
    CGContextDrawLinearGradient(ctx,
                                gradient,
                                start,
                                end,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Took about 0.005 seconds for 400 x 400
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"Gradient context draw took %f sec", (endTime - startTime));
    
    return gradientImage;
}

+ (UIImage*) createGradientWithFrame:(CGRect)frame
                          angleInDeg:(CGFloat)angleInDeg
                          startColor:(UIColor*)startColor
                            endColor:(UIColor*)endColor
{
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, NULL);
    
    CGFloat angle = DEGREES_TO_RADIANS(angleInDeg);
    CGPoint mid = CGPointMake(frame.size.width * 0.5f, frame.size.height * 0.5f);
    CGPoint start = CGPointMake(mid.x - (mid.x * cosf(angle)), mid.y + (mid.y * sinf(angle)));
    CGPoint end = CGPointMake(mid.x, mid.y);//mid.x + mid.x + 2 + (mid.x * cosf(angle)), mid.y - (mid.y * sinf(angle)));
    
    // Apply gradient
    CGContextDrawLinearGradient(ctx,
                                gradient,
                                start,
                                end,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Took about 0.005 seconds for 400 x 400
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"Gradient context draw took %f sec", (endTime - startTime));
    
    // TODO: test out radial gradient
    //    CGPoint gradCenter= CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    //    float gradRadius = MIN(self.bounds.size.width , self.bounds.size.height) ;
    //    CGContextDrawRadialGradient (ctx, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
    
    return gradientImage;
}

+ (UIImage*) createRadialGradientWithOrigin:(CGPoint)origin
                                    inFrame:(CGRect)frame
                                    atScale:(CGFloat)atScale
                                 startColor:(UIColor*)startColor
                                   endColor:(UIColor*)endColor
{
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, NULL);
    
    CGFloat radius = atScale * MIN(frame.size.width, frame.size.height);
    
    // Apply gradient
    CGContextDrawRadialGradient(ctx,
                                gradient,
                                origin, 0,
                                origin, radius,
                                0);
    CGGradientRelease(gradient);
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Took about 0.005 seconds for 400 x 400
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"Gradient context draw took %f sec", (endTime - startTime));
    
    return gradientImage;
}

+ (UIImage *)imageFromLayer:(CALayer *)layer
{
    // Took about 0.004 seconds for 400 x 400
    //    startTime = [[NSDate date] timeIntervalSince1970];
    //    //create the gradient
    //    CAGradientLayer *gradientLater = [CAGradientLayer layer];
    //    gradientLater.frame = frame;
    //    //this example is white-black gradient, change it to the color you want..
    //    gradientLater.colors = [NSArray arrayWithObjects:(id)[colorOne CGColor], (id)[colorTwo CGColor], nil];
    //    gradientLater.cornerRadius = frame.size.height/2.0f;
    //
    //    UIImage* outputImg = [self imageFromLayer:gradientLater];
    //
    //    endTime = [[NSDate date] timeIntervalSince1970];
    //    NSLog(@"Gradient Layer Create took %f sec", (endTime - startTime));
    
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, 0);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
