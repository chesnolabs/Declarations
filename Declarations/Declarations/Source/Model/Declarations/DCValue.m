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
@property (readwrite) NSString *title;

@end

@implementation DCValue

- (id)initWithCode:(NSString *)code
             value:(id)value
             title:(NSString *)title
             units:(NSString *)units
{
    self = [super init];
    
    if (self)
    {
        _code = [code copy];
        _value = [value copy];
        _units = [units copy];
        
        if (title != nil && title.length > 1)
        {
            NSString *firstLetter = [title substringToIndex:1];
            _title = [[firstLetter uppercaseString] stringByAppendingString:[title substringFromIndex:1]];
        }
    }
    
    return self;
}

#pragma mark - 

- (NSString *)description
{
    return [[super description] stringByAppendingFormat:@"[title:%@; code:%@; value:%@; units:%@]", self.title, self.code, self.value, self.units];
}

#pragma mark -

- (BOOL)isFamily
{
    double doubleValue = [self.code doubleValue];
    
    if ((doubleValue < 21.0 && ((int)(doubleValue * 10) % 10) == 1) ||
         doubleValue == 22.0 ||
         (doubleValue > 28.0 && doubleValue < 35.0) ||
         (doubleValue > 39.0 && doubleValue < 45.0) ||
         (doubleValue > 50.0 && doubleValue < 54.0) ||
         (doubleValue > 59.0 && doubleValue < 65))
    {
        return YES;
    }
    
    return NO;
}

@end
