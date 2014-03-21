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
@property (nonatomic, strong) GPUImageCropFilter *cropFilter;
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

        _cropFilter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0, 0,1,1)];

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
        
        [_element addTarget:_cropFilter];
        [_cropFilter addTarget:[_blurFilter imageInput]];
        [_blurFilter addBlurTarget:self];
        
        [view addObserver:self forKeyPath:@"frame" options:0 context:NULL];
        [view.layer addObserver:self forKeyPath:@"bounds" options:0 context:NULL];
        [view.layer addObserver:self forKeyPath:@"transform" options:0 context:NULL];
        [view.layer addObserver:self forKeyPath:@"position" options:0 context:NULL];
        [view.layer addObserver:self forKeyPath:@"zPosition" options:0 context:NULL];
        [view.layer addObserver:self forKeyPath:@"anchorPoint" options:0 context:NULL];
        [view.layer addObserver:self forKeyPath:@"anchorPointZ" options:0 context:NULL];
        [view.layer addObserver:self forKeyPath:@"zPosition" options:0 context:NULL];
        [view.layer addObserver:self forKeyPath:@"frame" options:0 context:NULL];
        [view.layer addObserver:self forKeyPath:@"transform" options:0 context:NULL];

    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.cropFilter != nil && self.view != nil) {
        [self.cropFilter setCropRegion:CGRectMake(0,0,1,1)];
    }
    
    [self update];
}

- (void)update
{
    [self.element update];
    /*
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf.element update];
    });
     */
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath: %@ and Object: %@",keyPath,object);
    if (object == self.view.layer && [keyPath isEqualToString:@"bounds"]) {
        CGRect newFrame = [[object valueForKeyPath:keyPath] CGRectValue];
        [self setFrame:newFrame];
    }
}

#pragma mark - Public Methods

- (void)blurWithRadius:(CGFloat)radius animated:(BOOL)animated
{
    if (animated) {
        if (self.blurFilter.blurRadiusPixels <= radius) {
            [self.blurFilter setBlurRadiusPixels:radius];
            [self.element update];
        }
        
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 1.0f;
                         } completion:^(BOOL finished) {}];
        
    } else {
        [self.blurFilter setBlurRadiusPixels:radius];
        [self.element update];
    }
    
}

- (void)unBlurAnimated:(BOOL)animated;
{
    if (animated) {
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 0.0f;
                         } completion:^(BOOL finished) {}];
        
        
    } else {
        self.alpha = 0.0f;
    }
}

@end
