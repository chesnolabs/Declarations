//
//  DCDeputy.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCPerson.h"

@interface DCPerson ()

@property (strong) NSMutableArray *declarationsStorage;

@end

@implementation DCPerson

- (id)init
{
    self = [super init];
    if (self)
    {
        self.declarationsStorage = [NSMutableArray array];
    }
    return self;
}

- (id)initWithJSONObject:(NSDictionary *)jsonObject
{
    return [self init];
}

- (NSArray *)declarations
{
    return self.declarationsStorage;
}

- (void)addDeclaration:(DCDeclaration *)aDeclaration
{
    if (aDeclaration != nil)
    {
        [self.declarationsStorage addObject:aDeclaration];
    }
}

@end
