//
//  FGFilterFlare.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/3/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGFilterFlare.h"
#import "GPUImageAlphaBlendFilter.h"
#import "GPUImagePicture.h"
#import "FGFilterHelper.h"
#import "FGGradientHelper.h"

@interface FGFilterFlare ()
@property (nonatomic, strong) UIImage* baseImage;
@end

@implementation FGFilterFlare

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
    
    UIColor *colorOne = [UIColor colorWithRed:1.00 green:0.75 blue:0.32 alpha:1.00];
    UIColor *colorTwo = [UIColor colorWithRed:1.00 green:0.73 blue:0.00 alpha:0.00];
    
    // TODO: implement a flare intensity field
    UIImage* overlayFlare = [FGGradientHelper createGradientWithFrame:CGRectMake(0, 0, self.baseImage.size.width, self.baseImage.size.height) angleInDeg:-160 startColor:colorOne endColor:colorTwo];
    
    //        UIImage* overlayFlare = [UIImage imageNamed:@"overlay_flare1"];
    
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
    return @"lookup_flare1.png";
}

@end
