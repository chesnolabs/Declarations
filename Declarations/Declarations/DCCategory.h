//
//  DCCategory.h
//  Declarations
//
//  Created by Vera Tkachenko on 6/25/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCValue.h"

@interface DCCategory : NSObject

@property (strong) NSString *name;
@property (strong) UIImage *icon;

@property (readonly) NSArray *values; // DCValue

- (void)addValue:(DCValue *)value;

@end
