//
//  FGFilterHelper.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 7/31/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGFilterHelper.h"

@implementation FGFilterHelper

+ (void) processImageSrc:(nonnull  GPUImagePicture*)imageSrc
                 through:(nullable GPUImageFilterGroup*)filterGroup
       toImageViewOutput:(nonnull  GPUImageView*)imageView
{
    [self processImageSrc:imageSrc
                  through:filterGroup
              thenThrough:nil
        toImageViewOutput:imageView];
}

+ (void) processImageSrc:(nonnull  GPUImagePicture*)imageSrc
                 through:(nullable GPUImageFilterGroup*)filterGroup
             thenThrough:(nullable GPUImageOutput<GPUImageInput> *)filter
       toImageViewOutput:(nonnull  GPUImageView*)imageView
{
    if (imageSrc == nil)
    {
        NSLog(@"GPUImagePicture nil, skipping filter setup");
        return;
    }
    
    if (imageView == nil)
    {
        NSLog(@"GPUImageView nil, skipping filter setup");
        return;
    }
    
    [imageSrc removeAllTargets];
    
    if (filterGroup.filterCount == 0)
    {
        if (filter == nil)
        {
            NSLog(@"imgSrc -> imageView");
            [imageSrc addTarget:imageView];
        }
        else
        {
            NSLog(@"imgSrc -> filter -> imageView");
            [imageSrc addTarget:filter];
            
            [filter removeAllTargets];
            [filter   addTarget:imageView];
        }
    }
    else
    {
        if (filter == nil)
        {
            NSLog(@"imgSrc -> filterGroup -> imageView");
            [imageSrc addTarget:filterGroup.initialFilters.firstObject];
            [filterGroup.terminalFilter removeAllTargets];
            [filterGroup.terminalFilter addTarget:imageView];
        }
        else
        {
            NSLog(@"imgSrc -> filter -> filterGroup -> imageView");
            [imageSrc addTarget:filter];
            [filter removeAllTargets];
            [filter addTarget:filterGroup.initialFilters.firstObject];
            
            [filterGroup.terminalFilter removeAllTargets];
            [filterGroup.terminalFilter addTarget:imageView];
        }
    }
    
    [imageSrc processImage];
}

+ (GPUImageFilterGroup*) createFilterGroupFromFilterArray:(NSArray<GPUImageOutput<GPUImageInput> *>*)filterArray
{
    GPUImageFilterGroup* filterGroup = [[GPUImageFilterGroup alloc] init];
    
    // Build out the filter group and the relationship in the chain of filter adjustments
    if (filterArray.count > 0)
    {
        for (int i = 0; i < filterArray.count; i++)
        {
            GPUImageOutput<GPUImageInput>* filter = filterArray[i];
            [filter removeAllTargets];
            if (i < (filterArray.count - 1))
            {
                GPUImageOutput<GPUImageInput> * nextFilter = filterArray[i+1];
                [filter addTarget:nextFilter];
            }
            else
            {
                NSLog(@"Setting terminal filter to %@", filter);
                [filterGroup setTerminalFilter:filter];
            }
            
            if (i == 0)
            {
                NSLog(@"Setting initial filter to %@", filter);
                [filterGroup setInitialFilters:[NSArray arrayWithObjects:filter, nil]];
            }
            
            [filterGroup addFilter:filter];
        }
    }
    NSLog(@"Created filter group %@", filterGroup);
    return filterGroup;
}

@end
