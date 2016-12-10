//
//  FGGradientHelper.h
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/4/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGGradientHelper : NSObject

+ (UIImage*) createLinearGradientWithOrigin:(CGPoint)origin
                                    inFrame:(CGRect)frame
                                    atScale:(CGFloat)atScale
                                 angleInDeg:(CGFloat)angleInDeg
                                 startColor:(UIColor*)startColor
                                   endColor:(UIColor*)endColor;

+ (UIImage*) createRadialGradientWithOrigin:(CGPoint)origin
                                    inFrame:(CGRect)frame
                                    atScale:(CGFloat)atScale
                                 startColor:(UIColor*)startColor
                                   endColor:(UIColor*)endColor;

+ (UIImage*) createGradientWithFrame:(CGRect)frame
                          angleInDeg:(CGFloat)angleInDeg
                          startColor:(UIColor*)startColor
                            endColor:(UIColor*)endColor;

@end
