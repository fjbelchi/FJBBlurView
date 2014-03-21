//
//  FJBBlurProtocol.h
//  FJBBlurView
//
//  Created by Fran_DEV on 23/02/14.
//  Copyright (c) 2014 FJBelchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FJBBlurProtocol <NSObject>
@required
- (id<GPUImageInput>)imageInput;
- (void)addBlurTarget:(id<GPUImageInput>)newTarget;
- (CGFloat)blurRadiusPixels;
- (void)setBlurRadiusPixels:(CGFloat)newValue;
@end
