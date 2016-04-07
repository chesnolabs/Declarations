//
//  NSBundle+DCBundleCategory.m
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "NSBundle+DCBundleCategory.h"
#import "NSArray+DCArrayCategory.h"

@implementation NSBundle (DCBundleCategory)

#pragma mark -
#pragma mark Class Methods

+ (id)objectWithClass:(Class)objectClass {
    return [self objectWithClass:objectClass nibNamed:NSStringFromClass(objectClass)];
}

+ (id)objectWithClass:(Class)objectClass nibNamed:(NSString *)name {
    return [self objectWithClass:objectClass nibNamed:name owner:self];
}

+ (id)objectWithClass:(Class)objectClass nibNamed:(NSString *)name owner:(id)owner {
    return [[NSBundle mainBundle] objectWithClass:objectClass nibNamed:name owner:owner];
}

#pragma mark -
#pragma mark Public

- (id)objectWithClass:(Class)objectClass {
    return [self objectWithClass:objectClass nibNamed:NSStringFromClass(objectClass)];
}

- (id)objectWithClass:(Class)objectClass nibNamed:(NSString *)name {
    return [self objectWithClass:objectClass nibNamed:name owner:self];
}

- (id)objectWithClass:(Class)objectClass nibNamed:(NSString *)name owner:(id)owner {
    NSArray *array = [self loadNibNamed:name owner:owner options:nil];
    return [array objectWithClass:objectClass];
}

@end
