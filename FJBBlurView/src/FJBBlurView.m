//
//  FJBBlur.m
//  FJBBlurView
//
//  Created by Fran_DEV on 23/02/14.
//  Copyright (c) 2014 FJBelchi. All rights reserved.
//

#import "FJBBlurView.h"
#import "FJBBlurProtocol.h"
#import "GPUImageGaussianBlurFilter+FJBBlur.h"
#import "GPUImageiOSBlurFilter+FJBBlur.h"

@interface FJBBlurView ()
@property (nonatomic, weak) UIView *view;
// -- Blur
//@property (nonatomic, strong) GPUImageCropFilter *cropFilter;
@property (nonatomic, strong) GPUImageUIElement *element;
@property (nonatomic, strong) id<FJBBlurProtocol> blurFilter;
@property (nonatomic, assign) FJBBlurStyle blurStyle;
@end

@implementation FJBBlurView

- (instancetype)initWithView:(UIView *)view withBlurStyle:(FJBBlurStyle)blurStyle
{
    self = [super initWithFrame:view.frame];
    
    if (self) {
        _view = view;
        _blurStyle = blurStyle;
        
        _element = [[GPUImageUIElement alloc] initWithView:view];

        switch (blurStyle) {
            case FJBBlurStyleGaussianBlur:
                 _blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
                break;
            case FJBBlurStyleiOSBlur:
                _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
                break;
            default:
                 _blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
                break;
        }
        
        //[_element addTarget:_cropFilter];
        //[_cropFilter addTarget:[_blurFilter imageInput]];
        [_element addTarget:[_blurFilter imageInput]];
        [_blurFilter addBlurTarget:self];
        self.blurRadius = 2.0f;
    }
    
    return self;
}

/*
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.cropFilter != nil && self.view != nil) {
        [self.cropFilter setCropRegion:CGRectMake(0,0,1,1)];
    }
    
    [self update];
}
*/

- (void)update
{
    [self.element update];
}

- (void) setBlurRadius:(CGFloat)blurRadius
{
    _blurRadius = blurRadius;
    [self.blurFilter setBlurRadiusPixels:_blurRadius];
    [self update];
}

#pragma mark - Public Methods

- (void)blurAnimated:(BOOL)animated withDuration:(CGFloat)duration
{
    [self.view insertSubview:self aboveSubview:self.view];

    if (animated) {
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 1.0f;
                         } completion:^(BOOL finished) {}];
        
    } else {
        self.alpha = 1.0f;
    }
    
}

- (void)unBlurAnimated:(BOOL)animated withDuration:(CGFloat)duration;
{
    if (animated) {
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
        
        
    } else {
        self.alpha = 0.0f;
        [self removeFromSuperview];
    }
}

@end
