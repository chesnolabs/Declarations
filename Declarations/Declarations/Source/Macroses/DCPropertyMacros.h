//
//  DCPropertyMacros.h
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#define DCViewControllerViewOfClassGetterSynthesize(theClass, getterName) \
- (theClass *)getterName { \
    if ([self.view isKindOfClass:[theClass class]]) { \
        return (theClass *)self.view; \
    } \
    return nil; \
}
