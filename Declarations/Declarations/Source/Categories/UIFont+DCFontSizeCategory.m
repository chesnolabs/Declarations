//
//  UIFont+DCFontSizeCategory.m
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "UIFont+DCFontSizeCategory.h"

static const CGFloat kScreenRatio = 568.0;

@implementation UIFont (DCFontSizeCategory)

#pragma mark -
#pragma mark Class Methods

+ (UIFont *)fontWithName:(NSString *)fontName proportionalToSize:(CGFloat)fontSize {
    return [[UIFont fontWithName:fontName size:fontSize] screenProportionalFont];
}

#pragma mark -
#pragma mark Public

- (UIFont *)screenProportionalFont {
    CGFloat fontSize = self.pointSize * [UIScreen mainScreen].bounds.size.height / kScreenRatio;
    
    return [UIFont fontWithName:self.fontName size:fontSize];
}

@end
