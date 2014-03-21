//
//  UIView+FJBBlur.m
//  FJBBlurView
//
//  Created by Fran_DEV on 23/02/14.
//  Copyright (c) 2014 FJBelchi. All rights reserved.
//

#import "UIView+FJBBlur.h"

static dispatch_once_t once;
static FJBBlurView *blur;

@implementation UIView (FJBBlur)

- (void)addBlurView
{
    __weak typeof(self) weakSelf = self;
    dispatch_once(&once, ^{
        blur = [[FJBBlurView alloc] initWithView:weakSelf withBlurStyle:FJBBlurStyleGaussianBlur];
        blur.alpha = 0.f;
        [weakSelf insertSubview:blur belowSubview:weakSelf];
    });
}

- (void)removeBlurView
{
    [blur removeFromSuperview];
}

- (FJBBlurView *) blurView
{
    return blur;
}


@end
