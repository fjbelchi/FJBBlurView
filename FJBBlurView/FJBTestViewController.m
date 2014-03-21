//
//  FJBTestViewController.m
//  FJBBlurView
//
//  Created by Fran_DEV on 23/02/14.
//  Copyright (c) 2014 FJBelchi. All rights reserved.
//

#import "FJBTestViewController.h"
#import "UIView+FJBBlur.h"

@interface FJBTestViewController ()
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIButton *blurButton;
@property (nonatomic) CGFloat blurFactor;
@end

@implementation FJBTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.photoView];
    [self.photoView addBlurView];
    [self.view addSubview:self.blurButton];
    [self.view setNeedsUpdateConstraints];
}

- (void) updateViewConstraints
{
    [self.view addConstraints:[self photoViewConstraints]];
    [self.view addConstraints:[self blurButtonConstraints]];
    [super updateViewConstraints];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (UIImageView *)photoView
{
    if (_photoView) {
        return _photoView;
    }
    
    _photoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nature.jpg"]];
    _photoView.translatesAutoresizingMaskIntoConstraints = NO;
    [_photoView setContentMode:UIViewContentModeScaleAspectFill];
    
    return _photoView;
}

- (NSArray *)photoViewConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_photoView);
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_photoView]|"
                                                                             options:0
                                                                             metrics:@{}
                                                                               views:viewsDictionary]];
    
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_photoView]|"
                                                                             options:0
                                                                             metrics:@{}
                                                                               views:viewsDictionary]];
    return [constraints copy];
}

- (UIButton *)blurButton
{
    if (_blurButton) {
        return _blurButton;
    }
    
    _blurButton = [[UIButton alloc] init];
    _blurButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_blurButton setTitle:@"Blur/Unblur" forState:UIControlStateNormal];
    [_blurButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_blurButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [_blurButton addTarget:self action:@selector(blurButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return _blurButton;
}

- (NSArray *)blurButtonConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_blurButton);
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.blurButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0
                                                         constant:0]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_blurButton(==40)]"
                                                                             options:0
                                                                             metrics:@{}
                                                                               views:viewsDictionary]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_blurButton]|"
                                                                             options:0
                                                                             metrics:@{}
                                                                               views:viewsDictionary]];
    return [constraints copy];
}

#pragma mark - Actions

- (void)blurButtonClicked:(id)sender
{
    if (self.blurFactor == 16) {
        self.blurFactor = 0.1;
        [[self.photoView blurView] unBlurAnimated:YES];
    } else {
        self.blurFactor = 16;
        [[self.photoView blurView] blurWithRadius:self.blurFactor animated:YES];
    }
    
}

@end
