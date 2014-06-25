//
//  DCGeneralInfo.m
//  Declarations
//
//  Created by tanlan on 5/26/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCGeneralInfo.h"

@implementation DCGeneralInfo

@synthesize familyMembers = _familyMembers;

- (id)initWithFamilyMembers:(NSArray *)members
{
    self = [super init];
    
    if (self != nil)
    {
        _familyMembers = [NSArray arrayWithArray:members];
    }
    
    return self;
}

@end
