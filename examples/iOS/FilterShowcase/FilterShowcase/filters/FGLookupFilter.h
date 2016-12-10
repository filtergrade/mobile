//
//  FGLookupFilter.h
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/1/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "GPUImageFilterGroup.h"

@class GPUImagePicture;
@class GPUImageLookupFilter;

@interface FGLookupFilter : GPUImageFilterGroup {
    
    GPUImagePicture* lookupImageSource;
    GPUImageLookupFilter* lookupFilter;
}

@property (nonatomic) CGFloat intensity;

@end
