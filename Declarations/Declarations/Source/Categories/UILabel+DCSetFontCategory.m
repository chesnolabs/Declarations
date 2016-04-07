//
//  UILabel+DCSetFontCategory.m
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "UILabel+DCSetFontCategory.h"
#import "UIFont+DCFontSizeCategory.h"

@implementation UILabel (DCSetFontCategory)

- (void)setFontWithName:(NSString *)fontFamily proportionalToSize:(NSUInteger)size {
    [self setFont:[UIFont fontWithName:fontFamily proportionalToSize:size]];
}

@end
