//
//  UILabel+DCSetFontCategory.h
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DCSetFontCategory)

- (void)setFontWithName:(NSString *)fontFamily proportionalToSize:(NSUInteger)size;

@end
