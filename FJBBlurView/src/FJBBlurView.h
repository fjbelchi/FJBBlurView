//
//  FJBBlur.h
//  FJBBlurView
//
//  Created by Fran_DEV on 23/02/14.
//  Copyright (c) 2014 FJBelchi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

typedef NS_ENUM(NSInteger, FJBBlurStyle) {
    FJBBlurStyleGaussianBlur,
    FJBBlurStyleiOSBlur
};

@interface FJBBlurView : GPUImageView
- (instancetype) initWithView:(UIView *)view withBlurStyle:(FJBBlurStyle)blurStyle;
- (void)update;
- (void)blurWithRadius:(CGFloat)radius animated:(BOOL)animated;
- (void)unBlurAnimated:(BOOL)animated;
@end
