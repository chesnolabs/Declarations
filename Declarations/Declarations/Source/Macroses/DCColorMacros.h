//
//  DCColorMacros.h
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "UIColor+DCColorCategory.h"

#ifndef DCColorMacros_h
#define DCColorMacros_h

#define UIColorFromRGBA(r, g, b, a) [UIColor colorWithIntRed:r green:g blue:b alpha:a]

#define kDCSelectedScopeBarColor        UIColorFromRGBA(61, 29, 92, 1.0)
#define kDCDeselectedScopeBarColor      [UIColor darkGrayColor]


#endif /* DCColorMacros_h */
