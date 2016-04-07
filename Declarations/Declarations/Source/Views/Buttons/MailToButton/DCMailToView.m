//
//  DCMailToView.m
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "DCMailToView.h"

#import "NSBundle+DCBundleCategory.h"
#import "UILabel+DCSetFontCategory.h"

@interface DCMailToView ()
@property (nonatomic, weak) UIView  *rootView;

@end

@implementation DCMailToView

#pragma mark -
#pragma mark Class Functions

+ (instancetype)mailToViewInView:(UIView *)view {
    DCMailToView *mailToView = [NSBundle objectWithClass:[self class]];
    mailToView.rootView = view;
    
    [mailToView show];
    
    return mailToView;
}

#pragma mark -
#pragma mark LifeCycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userInteractionEnabled = NO;
    
    UILabel *label = self.mailToLabel;
    UIFont *currentFont = label.font;
    
    [label setFontWithName:currentFont.fontName proportionalToSize:currentFont.pointSize];
}

#pragma mark -
#pragma mark Privat

- (void)show {
    UIView *view = self.rootView;
    CGRect frame = view.frame;
    frame.origin = CGPointZero;
    self.frame = frame;
    
    [view addSubview:self];
}

@end
