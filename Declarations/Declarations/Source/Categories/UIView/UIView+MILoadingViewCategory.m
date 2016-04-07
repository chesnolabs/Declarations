//
//  UIView+MILoadingViewCategory.m
//  miinu
//
//  Created by Varvara Mironova on 7/29/15.
//  Copyright (c) 2015 Miinu. All rights reserved.
//

#import "UIView+MILoadingViewCategory.h"
#import "VMLoadingView.h"

#import <objc/runtime.h>

static void * MILoadingViewPropertyKey = &MILoadingViewPropertyKey;

@implementation UIView (MILoadingViewCategory)

@dynamic loadingView;

#pragma mark -
#pragma mark Accessors

- (VMLoadingView *)loadingView {
    return objc_getAssociatedObject(self, MILoadingViewPropertyKey);
}

- (void)setLoadingView:(VMLoadingView *)loadingView {
    objc_setAssociatedObject(self, MILoadingViewPropertyKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
#pragma mark Public

- (void)showLoadingView {
    self.loadingView = [VMLoadingView loadingViewInView:self];
}

- (void)hideLoadingView {
    [self.loadingView hide];
        
    self.loadingView = nil;
}

@end
