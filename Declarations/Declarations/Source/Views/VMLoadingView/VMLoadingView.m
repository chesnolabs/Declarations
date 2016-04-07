//
//  VMLoadingView.m
//  miinu
//
//  Created by Varvara Mironova on 11.06.15.
//  Copyright (c) 2015 Miinu. All rights reserved.
//

#import "VMLoadingView.h"
#import "NSBundle+DCBundleCategory.h"

static const NSUInteger VMAnimationDuration = 0.6;
static const CGFloat    VMMaxAlpha          = 0.6;
static const CGFloat    VMMinAlpha          = 0.0;
static const CGFloat    VMDilay             = 0.0;

@interface VMLoadingView ()
@property (nonatomic, weak)     UIView      *rootView;

@property (nonatomic, assign)   BOOL    loadingViewHidden;

- (void)show;

@end

@implementation VMLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loadingViewInView:(UIView *)view {
    VMLoadingView *loadingView = [NSBundle objectWithClass:[self class]];
    loadingView.rootView = view;
    loadingView.loadingViewHidden = YES;
    
    [loadingView show];
    
    return loadingView;
}

#pragma mark -
#pragma mark Privat

- (void)show {
    if (self.loadingViewHidden) {
        UIView *view = self.rootView;
        CGRect frame = view.frame;
        frame.origin = CGPointZero;
        self.frame = frame;
        
        [view addSubview:self];
        
        [self.spinner startAnimating];
        
        [self animateWithDuration:VMAnimationDuration withAlpha:VMMaxAlpha withCompletionHandler:nil];
        
        self.loadingViewHidden = NO;
    }
}

#pragma mark -
#pragma mark Public

- (void)hide {
    if (!self.loadingViewHidden && [self isDescendantOfView:self.rootView]) {
        [self.spinner stopAnimating];
        [self animateWithDuration:VMAnimationDuration
                        withAlpha:VMMinAlpha
            withCompletionHandler:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        
        self.loadingViewHidden = YES;
    }
}

#pragma mark -
#pragma mark Private

- (void)animateWithDuration:(CGFloat)duration
                  withAlpha:(CGFloat)alpha
      withCompletionHandler:(void (^)(BOOL finished))completionBlock
{
    [UIView animateWithDuration:duration
                          delay:VMDilay
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.alpha = alpha;
                     }
                     completion:completionBlock];
}

@end
