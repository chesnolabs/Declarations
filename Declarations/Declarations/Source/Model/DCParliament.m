//
//  DCParliament.m
//  Declarations
//
//  Created by Vera Tkachenko on 1/7/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import "DCParliament.h"

@interface DCParliament ()

@property (strong) NSMutableArray *deputiesStorage;

@end

@implementation DCParliament

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _deputiesStorage = [NSMutableArray new];
    }
    return self;
}


- (void)addDeputy:(DCPerson *)deputy
{
    if (deputy)
    {
        [self.deputiesStorage addObject:deputy];
    }
}

- (NSArray *)deputies
{
    return self.deputiesStorage;
}

@end
