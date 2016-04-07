//
//  UIFont+DCFontSizeCategory.h
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (DCFontSizeCategory)

+ (UIFont *)fontWithName:(NSString *)fontName proportionalToSize:(CGFloat)fontSize;

- (UIFont *)screenProportionalFont;

@end
