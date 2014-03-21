//
//  GPUImageGaussianBlurFilter+FJBBlur.m
//  FJBBlurView
//
//  Created by Fran_DEV on 23/02/14.
//  Copyright (c) 2014 FJBelchi. All rights reserved.
//

#import "GPUImageGaussianBlurFilter+FJBBlur.h"

@implementation GPUImageGaussianBlurFilter (FJBBlur)

- (id<GPUImageInput>)imageInput
{
    return self;
}

- (void)addBlurTarget:(id<GPUImageInput>)newTarget
{
    [self addTarget:newTarget];
}

- (CGFloat)blurRadiusPixels
{
    return self.blurRadiusInPixels;
}

- (void)setBlurRadiusPixels:(CGFloat)newValue
{
    self.blurRadiusInPixels = newValue;
}

@end
