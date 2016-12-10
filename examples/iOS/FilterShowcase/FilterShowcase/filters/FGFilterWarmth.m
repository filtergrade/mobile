//
//  FGFilterWarmth.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/3/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGFilterWarmth.h"
#import "GPUImageAlphaBlendFilter.h"
#import "GPUImagePicture.h"
#import "FGFilterHelper.h"
#import "FGGradientHelper.h"

@interface FGFilterWarmth ()
@property (nonatomic, strong) UIImage* baseImage;
@end

@implementation FGFilterWarmth

- (id)initWithInput:(UIImage*)baseImage
{
    if (self = [super init])
    {
        _baseImage = baseImage;
        [self processImage];
    }
    
    return self;
}

- (void) processImage
{
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    
    GPUImageHardLightBlendFilter* blendFilter = [[GPUImageHardLightBlendFilter alloc] init];
    
    GPUImagePicture* baseImageSrc = [[GPUImagePicture alloc] initWithImage:self.baseImage];
    
    [blendFilter useNextFrameForImageCapture];
    
    [baseImageSrc addTarget:self];
    [self.terminalFilter addTarget:blendFilter];
    [baseImageSrc processImage];
    
    // Create Gradient
    UIColor *colorOne = [UIColor colorWithRed:(0.0f / 255.0f) green:(0.0f / 255.0f) blue:(0.0f / 255.0f) alpha:0.00f];
    UIColor *colorTwo = [UIColor colorWithRed:(0.0f / 255.0f) green:(0.0f / 255.0f) blue:(0.0f / 255.0f) alpha:0.5f];
    
    CGRect frame = CGRectMake(0, 0, self.baseImage.size.width, self.baseImage.size.height);
    CGPoint origin = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    
    UIImage* overlayFlare = [FGGradientHelper createRadialGradientWithOrigin:origin
                                                                     inFrame:frame
                                                                     atScale:1.5f
                                                                  startColor:colorOne
                                                                    endColor:colorTwo];
    
    GPUImagePicture* overlayImageSrc = [[GPUImagePicture alloc] initWithImage:overlayFlare];
    
    [overlayImageSrc addTarget:blendFilter];
    [overlayImageSrc processImage];
    
    _outputImage = [blendFilter imageFromCurrentFramebuffer];
    
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"Flare filter took %f sec", (endTime-startTime));
}

- (void) setIntensity:(CGFloat) intensity
{
    [super setIntensity:intensity];
    [self processImage];
}

- (NSString*) lookupImageName
{
    return @"lookup_warmth.png";
}

@end
