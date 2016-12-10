//
//  FGFilterWasted.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/1/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGFilterWasted.h"
#import "GPUImageBrightnessFilter.h"

@implementation FGFilterWasted

- (GPUImageFilter*) baseImageFilter
{
    GPUImageBrightnessFilter* brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    brightnessFilter.brightness = -0.25f;
    return brightnessFilter;
}

- (UIImage*) overlayImageWithBaseSize:(CGSize)size
{
    return [UIImage imageNamed:@"wasted_gta.png"];
}

@end
