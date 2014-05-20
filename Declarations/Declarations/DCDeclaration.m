//
//  DCDeclaration.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeclaration.h"

@implementation DCDeclaration

- (id)initWithJSONObject:(NSDictionary *)jsonObject
{
    return [self init];
}

- (NSString *)title
{
    if (_title == nil)
    {
        _title = [NSString stringWithFormat:@"%i", self.year];
    }
    return _title;
}

@end
