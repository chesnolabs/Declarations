//
//  DCDeputy.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeputy.h"

@interface DCDeputy ()

@property (strong) NSMutableArray *declarationsStorage;

@end

@implementation DCDeputy

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.declarationsStorage = [NSMutableArray array];
    }
    return self;
}

- (void)addDeclaration:(DCDeclaration *)aDeclaration
{
    if (aDeclaration != nil)
    {
        [self.declarationsStorage addObject:aDeclaration];
    }
}

@end
