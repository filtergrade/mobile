//
//  FGFilterFlareIce.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/3/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGFilterFlareIce.h"
#import "GPUImageAlphaBlendFilter.h"
#import "GPUImagePicture.h"
#import "FGFilterHelper.h"
#import "FGGradientHelper.h"

@interface FGFilterFlareIce ()
@property (nonatomic, strong) UIImage* baseImage;
@end

@implementation FGFilterFlareIce

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
    
    GPUImageScreenBlendFilter* blendFilter = [[GPUImageScreenBlendFilter alloc] init];
    //        GPUImageAlphaBlendFilter* blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    //        blendFilter.mix = 0.8f;
    
    GPUImagePicture* baseImageSrc = [[GPUImagePicture alloc] initWithImage:self.baseImage];
    
    [blendFilter useNextFrameForImageCapture];
    //[self useNextFrameForImageCapture];
    
    [baseImageSrc addTarget:self];
    [self.terminalFilter addTarget:blendFilter];
    [baseImageSrc processImage];
    
    // Create gradient
    UIColor *colorOne = [UIColor colorWithRed:(49.0f / 255.0f) green:(224.0f / 255.0f) blue:(230.0f / 255.0f) alpha:1.00f];
    UIColor *colorTwo = [UIColor colorWithRed:(76.0f / 255.0f) green:(207.0f / 255.0f) blue:(222.0f / 255.0f) alpha:0.00f];
    
    CGRect frame = CGRectMake(0, 0, self.baseImage.size.width, self.baseImage.size.height);
//    CGPoint origin = CGPointMake(frame.size.width * 0.73f, frame.size.height * 0.41f);
//    
//    UIImage* overlayFlare = [FGGradientHelper createLinearGradientWithOrigin:origin
//                                                                     inFrame:frame
//                                                                     atScale:0.556f
//                                                                  angleInDeg:-160
//                                                                  startColor:colorOne
//                                                                    endColor:colorTwo];
    
    UIImage* overlayFlare = [FGGradientHelper createGradientWithFrame:frame angleInDeg:-160 startColor:colorOne endColor:colorTwo];
    
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
    return @"lookup_flare_ice.png";
}

@end
