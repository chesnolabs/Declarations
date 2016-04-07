//
//  UIView+MILoadingViewCategory.h
//  miinu
//
//  Created by Varvara Mironova on 7/29/15.
//  Copyright (c) 2015 Miinu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VMLoadingView;

@interface UIView (MILoadingViewCategory)
@property (nonatomic, strong)   VMLoadingView     *loadingView;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
