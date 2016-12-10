//
//  FGFilterNoise.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/3/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGFilterNoise.h"
#import "GPUImageAlphaBlendFilter.h"
#import "GPUImagePicture.h"
#import "FGFilterHelper.h"
#import "FGGradientHelper.h"

@interface FGFilterNoise ()
@property (nonatomic, strong) UIImage* baseImage;
@end

@implementation FGFilterNoise

- (id)initWithInput:(UIImage*)baseImage
{
    if (self = [super init])
    {
        _intensity = 1.0f;
        _baseImage = baseImage;
        [self processImage];
    }
    
    return self;
}

- (void) processImage
{
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    
    GPUImageOverlayBlendFilter* blendFilter = [[GPUImageOverlayBlendFilter alloc] init];
    //        GPUImageAlphaBlendFilter* blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    //        blendFilter.mix = 0.8f;
    
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = self.intensity;
    
    GPUImagePicture* baseImageSrc = [[GPUImagePicture alloc] initWithImage:self.baseImage];
    
    [blendFilter useNextFrameForImageCapture];
    //[self useNextFrameForImageCapture];
    
    [baseImageSrc addTarget:blendFilter];
    [baseImageSrc processImage];
    
    UIImage* noise = [UIImage imageNamed:@"kodak_grain.jpg"];
    
    GPUImagePicture* overlayImageSrc = [[GPUImagePicture alloc] initWithImage:noise];
    
    [overlayImageSrc addTarget:opacityFilter];
    [opacityFilter addTarget:blendFilter];
    [overlayImageSrc processImage];
    
    _outputImage = [blendFilter imageFromCurrentFramebuffer];
    
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"Flare filter took %f sec", (endTime-startTime));
}

- (void) setIntensity:(CGFloat) intensity
{
    _intensity = intensity;
    [self processImage];
}

@end
