//
//  FGFilterWarmth.h
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/3/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGLookupFilter.h"

@interface FGFilterWarmth : FGLookupFilter

- (id)initWithInput:(UIImage*)baseImage;

@property (nonatomic, strong) UIImage* outputImage;

@end
