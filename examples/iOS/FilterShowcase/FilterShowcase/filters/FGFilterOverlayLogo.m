//
//  FGFilterOverlayLogo.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/9/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGFilterOverlayLogo.h"
#import "GPUImageBrightnessFilter.h"

@implementation FGFilterOverlayLogo

- (UIImage*) overlayImageWithBaseSize:(CGSize)size
{
    return [UIImage imageNamed:@"overlay_logo"];
}

+ (UIImage*) overlayImageWithBaseSize:(CGSize)size
{
    return [UIImage imageNamed:@"overlay_logo"];
}

+ (CGFloat) overlayImageAspectRatio
{
    return 400.0f / 1200.0f;  // height / width
}

@end
