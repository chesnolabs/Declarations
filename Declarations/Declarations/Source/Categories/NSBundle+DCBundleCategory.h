//
//  NSBundle+DCBundleCategory.h
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (DCBundleCategory)
+ (id)objectWithClass:(Class)objectClass;
+ (id)objectWithClass:(Class)objectClass nibNamed:(NSString *)name;
+ (id)objectWithClass:(Class)objectClass nibNamed:(NSString *)name owner:(id)owner;

- (id)objectWithClass:(Class)objectClass;
- (id)objectWithClass:(Class)objectClass nibNamed:(NSString *)name;
- (id)objectWithClass:(Class)objectClass nibNamed:(NSString *)name owner:(id)owner;

@end
