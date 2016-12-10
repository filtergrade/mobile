//
//  FGOverlayFilter.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/1/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGOverlayFilter.h"
#import "GPUImagePicture.h"
#import "GPUImageBrightnessFilter.h"

@implementation FGOverlayFilter

- (id)initWithInput:(UIImage*)baseImage andOverlayWithAlpha:(CGFloat)alpha
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    if (baseImage == nil)
    {
        return nil;
    }
    
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    UIImage* overlayImage = [self overlayImageWithBaseSize:baseImage.size];
#else
    NSImage* overlayImage = [self overlayImageWithBaseSize:baseImage.size];
#endif
    
    NSAssert(overlayImage, @"To use FGOverlayFilter you need to add the overlayImage to your application bundle.");
    
    CGFloat ow = baseImage.size.width;
    CGFloat oh = baseImage.size.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ow, oh), YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGFloat halfWidth = ow * 0.5f;
    CGFloat halfHeight = oh * 0.5f;
    // Now we can draw anything we want into this new context.
    CGPoint origin = CGPointMake(halfWidth - (overlayImage.size.width * 0.5f), halfHeight - (overlayImage.size.height * 0.5f));
    [overlayImage drawAtPoint:origin];
    
    // Clean up and get the new image.
    UIGraphicsPopContext();
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.mix = alpha;
    
    overlayImageSrc = [[GPUImagePicture alloc] initWithImage:newImage];
    baseImageSrc = [[GPUImagePicture alloc] initWithImage:baseImage];
    
    [self useNextFrameForImageCapture];
    
    GPUImageFilter* filter = [self baseImageFilter];
    if (filter != nil)
    {
        [baseImageSrc addTarget:filter];
        [filter addTarget:self];
    }
    else
    {
        [baseImageSrc addTarget:self];
    }
    [baseImageSrc processImage];
    
    [overlayImageSrc addTarget:self];
    [overlayImageSrc processImage];
    
    _outputImage = [self imageFromCurrentFramebuffer];
    
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"Overlay filter took %f sec", (endTime-startTime));
    
    return self;
}

- (id)initWithInput:(UIImage*)baseImage
{
    return [self initWithInput:baseImage andOverlayWithAlpha:1.0f];
}

#pragma mark Sub-class overrides

- (GPUImageFilter*) baseImageFilter
{
    // TO BE IMPLEMENTED BY SUB_CLASS
    return nil;
}

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
- (UIImage*) overlayImageWithBaseSize:(CGSize)size
{
    // TO BE IMPLEMENTED BY SUB_CLASS
    NSLog(@"ERROR: this should never be called");
    return nil;
}
#else
- (NSImage*) overlayImageWithBaseSize:(CGSize)size
{
    // TO BE IMPLEMENTED BY SUB_CLASS
    NSLog(@"ERROR: this should never be called");
    return nil;
}
#endif

@end
