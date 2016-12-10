//
//  FGFilterOverlayLogo.h
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/9/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGOverlayFilter.h"

@interface FGFilterOverlayLogo : FGOverlayFilter

- (UIImage*) overlayImageWithBaseSize:(CGSize)size;
+ (UIImage*) overlayImageWithBaseSize:(CGSize)size;

+ (CGFloat) overlayImageAspectRatio;

@end
