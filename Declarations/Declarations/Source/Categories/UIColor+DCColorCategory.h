//
//  UIColor+DCColorCategory.h
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DCColorCategory)

+ (UIColor *)colorWithIntRed:(NSInteger)red
                       green:(NSInteger)green
                        blue:(NSInteger)blue;

+ (UIColor *)colorWithIntRed:(NSInteger)red
                       green:(NSInteger)green
                        blue:(NSInteger)blue
                       alpha:(CGFloat)alpha;

@end
