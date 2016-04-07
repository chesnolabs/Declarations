//
//  UIColor+DCColorCategory.m
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "UIColor+DCColorCategory.h"

static const CGFloat kDCColorConst = 255.0;

@implementation UIColor (DCColorCategory)

#pragma mark -
#pragma mark Class Methods

+ (UIColor *)colorWithIntRed:(NSInteger)red
                       green:(NSInteger)green
                        blue:(NSInteger)blue
{
    return [self colorWithIntRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithIntRed:(NSInteger)red
                       green:(NSInteger)green
                        blue:(NSInteger)blue
                       alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(float)red / kDCColorConst
                           green:(float)green / kDCColorConst
                            blue:(float)blue / kDCColorConst
                           alpha:alpha];
}

@end
