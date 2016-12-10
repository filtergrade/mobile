//
//  FGLookupFilter.m
//  FilterShowcase
//
//  Created by Michael L DePhillips on 8/1/16.
//  Copyright © 2016 Cell Phone. All rights reserved.
//

#import "FGLookupFilter.h"
#import "GPUImagePicture.h"
#import "GPUImageLookupFilter.h"
#import "GPUImageAlphaBlendFilter.h"

@implementation FGLookupFilter

- (id)init;
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    NSString* lookupName = [self lookupImageName];
    
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    UIImage *image = [UIImage imageNamed:lookupName];
#else
    NSImage *image = [NSImage imageNamed:lookupName];
#endif
    
    NSAssert(image, @"To use FGFilterMatte you need to add lookup_matte.png to your application bundle.");
    
    lookupImageSource = [[GPUImagePicture alloc] initWithImage:image];
    lookupFilter = [[GPUImageLookupFilter alloc] init];
    [self addFilter:lookupFilter];
    
    [lookupImageSource addTarget:lookupFilter atTextureLocation:1];
    [lookupImageSource processImage];        
    
    self.initialFilters = [NSArray arrayWithObjects:lookupFilter, nil];
    self.terminalFilter = lookupFilter;
    
    return self;
}

- (void) setIntensity:(CGFloat) intensity
{
    _intensity = intensity;
    lookupFilter.intensity = intensity;
    [lookupImageSource processImage];
}

#pragma mark -
#pragma mark Accessors

- (NSString*) lookupImageName
{
    // TO BE IMPLEMENTED BY SUB_CLASS
    NSLog(@"ERROR: this should never be called");
    return nil;
}

@end
