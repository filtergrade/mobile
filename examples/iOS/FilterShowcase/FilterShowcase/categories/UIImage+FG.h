//
//  UIImage+FG.h
//  FilterShowcase
//
//  Created by Michael L DePhillips on 7/31/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (FG)

+(UIImage*)imageWithImage: (UIImage*) sourceImage
            scaledToWidth: (float) i_width;

- (UIImage *)croppedImage:(CGRect)bounds;

- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

@end
