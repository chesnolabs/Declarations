//
//  NSArray+DCArrayCategory.m
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "NSArray+DCArrayCategory.h"

@implementation NSArray (DCArrayCategory)

- (id)objectWithClass:(Class)objectClass {
    for (id object in self) {
        if ([object isMemberOfClass:objectClass]) {
            return object;
        }
    }
    
    return nil;
}

@end
