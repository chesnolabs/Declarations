//
//  DCCategory.m
//  Declarations
//
//  Created by Vera Tkachenko on 6/25/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCCategory.h"

@interface DCCategory ()

@property (strong) NSMutableArray *valuesStorage;

@end

@implementation DCCategory

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.icon = [UIImage imageNamed:@"Vehicle"];
        self.valuesStorage = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)values
{
    return self.valuesStorage;
}

- (void)addValue:(DCValue *)value
{
    if (value)
    {
        [self.valuesStorage addObject:value];
    }
}

@end
