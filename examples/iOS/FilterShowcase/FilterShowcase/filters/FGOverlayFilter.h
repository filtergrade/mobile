//
//  FGOverlayFilter.h
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/1/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "GPUImageAlphaBlendFilter.h"

@class GPUImagePicture;

@interface FGOverlayFilter : GPUImageAlphaBlendFilter {
    GPUImagePicture* overlayImageSrc;
    GPUImagePicture* baseImageSrc;
}

- (id)initWithInput:(UIImage*)baseImage;

- (id)initWithInput:(UIImage*)baseImage andOverlayWithAlpha:(CGFloat)alpha;

@property (nonatomic, strong) UIImage* outputImage;

@end
