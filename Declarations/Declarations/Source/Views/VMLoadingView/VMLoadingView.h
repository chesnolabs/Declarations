//
//  VMLoadingView.h
//  miinu
//
//  Created by Varvara Mironova on 11.06.15.
//  Copyright (c) 2015 Miinu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VMLoadingView : UIView
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic, readonly, getter=isLoadingViewHidden) BOOL    loadingViewHidden;

+ (instancetype)loadingViewInView:(UIView *)view;

- (void)hide;

@end