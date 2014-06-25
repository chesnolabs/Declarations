//
//  DCValue.m
//  Declarations
//
//  Created by tanlan on 5/26/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCValue.h"

@interface DCValue ()

@property (readwrite) NSString *code;
@property (readwrite) id value;
@property (readwrite) NSString *units;

@end

@implementation DCValue

- (id)initWithCode:(NSString *)code
             value:(id)value
             units:(NSString *)units
{
    self = [super init];
    
    if (self)
    {
        _code = [code copy];
        _value = [value copy];
        _units = [units copy];
    }
    
    return self;
}

#pragma mark - 

- (NSString *)description
{
    return [[super description] stringByAppendingFormat:@"[code:%@; value:%@; units:%@]", self.code, self.value, self.units];
}

@end
