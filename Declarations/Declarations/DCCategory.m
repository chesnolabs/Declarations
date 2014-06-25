//
//  DCCategory.m
//  Declarations
//
//  Created by Vera Tkachenko on 6/25/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCCategory.h"

@implementation DCCategory

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.icon = [UIImage imageNamed:@"Vehicle"];
    }
    return self;
}


@end
