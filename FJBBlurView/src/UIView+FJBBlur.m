//
//  UIView+FJBBlur.m
//  FJBBlurView
//
//  Created by Fran_DEV on 23/02/14.
//  Copyright (c) 2014 FJBelchi. All rights reserved.
//

#import "UIView+FJBBlur.h"
#import <objc/runtime.h>


NSString const *blurKey = @"fjblurView.blurKey";

@implementation UIView (FJBBlur)

- (void)setBlurView:(FJBBlurView *)blurView
{
    objc_setAssociatedObject(self, &blurKey, blurView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FJBBlurView *)blurView
{
    FJBBlurView *blurView = objc_getAssociatedObject(self, &blurKey);

    if (blurView) {
        return blurView;
    }
    
    blurView = [[FJBBlurView alloc] initWithView:self withBlurStyle:FJBBlurStyleGaussianBlur];
    blurView.alpha = 0.f;
    
    [self setBlurView:blurView];
    
    return blurView;
}


@end
