//
//  DCNavigationBar.m
//  Declarations
//
//  Created by Varvara Mironova on 3/25/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "DCNavigationBar.h"

static const NSUInteger kDCTouchedSpace = 40.0;

@interface DCNavigationBar ()
@property (nonatomic, strong) UIView *untouchedView;

@end

@implementation DCNavigationBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGRect frame = self.frame;
    CGFloat statusBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGRect untouchedFrame = CGRectMake(kDCTouchedSpace,
                                       statusBarHeight,
                                       CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * kDCTouchedSpace,
                                       CGRectGetHeight(frame));
    
    self.untouchedView = [[UIView alloc] initWithFrame:untouchedFrame];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL pointInSide = [super pointInside:point withEvent:event];
    UIView *view = self.untouchedView;
    CGPoint convertedPoint = [view convertPoint:point fromView:self];
    if ([view pointInside:convertedPoint withEvent:event]) {
        pointInSide = NO;
    }
    
    return pointInSide;
}

@end
