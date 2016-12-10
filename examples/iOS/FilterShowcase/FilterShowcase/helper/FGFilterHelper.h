//
//  FGFilterHelper.h
//  FilterShowcase
//
//  Created by Michael L DePhillips on 7/31/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

@interface FGFilterHelper : NSObject

/*
 * Creates a Filter Group from an array of filters, aka an filter process that has both an input and an Nullable output
 *
 * @param filterArray - an array of filters to connect in a linear chain in filter group
 */
+ (nonnull GPUImageFilterGroup*) createFilterGroupFromFilterArray:(nullable NSArray<GPUImageOutput<GPUImageInput> *>*)filterArray;

/*
 * @param imageSrc    - the picture input and start of the filter chain that will have the filters applied
 * @param filterGroup - a group of filters chained linearly, the imageSrc will go through these first
 * @param filter      - a filter that will be applied after the filterGroup to the imageSrc
 * @param imageView   - the output of the process will be displayed in the image view
 */
+ (void) processImageSrc:(nonnull  GPUImagePicture*)imageSrc
                 through:(nullable GPUImageFilterGroup*)filterGroup
             thenThrough:(nullable GPUImageOutput<GPUImageInput> *)filter
       toImageViewOutput:(nonnull  GPUImageView*)imageView;

/*
 * @param imageSrc    - the picture input and start of the filter chain that will have the filters applied
 * @param filterGroup - a group of filters chained linearly, the imageSrc will go through these first
 * @param imageView   - the output of the process will be displayed in the image view
 */
+ (void) processImageSrc:(nonnull  GPUImagePicture*)imageSrc
                 through:(nullable GPUImageFilterGroup*)filterGroup
       toImageViewOutput:(nonnull  GPUImageView*)imageView;

@end
