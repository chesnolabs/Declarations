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
    self = [super init];
    if (self)
    {
        self.declarationsStorage = [NSMutableArray array];
        id lastNameJson = jsonObject[@"last_name"];
        if (lastNameJson == [NSNull null] || ![lastNameJson isKindOfClass:[NSString class]] || ([lastNameJson isKindOfClass:[NSString class]] && ((NSString *)lastNameJson).length == 0))
        {
            //NSLogD(@"Failed to create person from JSON %@", jsonObject);
            return nil;
        }

        self.lastName = jsonObject[@"last_name"];
        if (jsonObject[@"first_name"] != [NSNull null])
        {
            self.firstName = jsonObject[@"first_name"];
        }
        if (jsonObject[@"second_name"] != [NSNull null])
        {
            self.middleName = jsonObject[@"second_name"];
        }
        self.identifier = [jsonObject[@"id"] unsignedIntegerValue];
    }
    return self;
}

- (NSString *)fullName
{
    if (self.firstName.length == 0)
    {
        return [NSString stringWithFormat:@"%@", self.lastName];
    }
    if (self.middleName.length == 0)
    {
        return [NSString stringWithFormat:@"%@ %@.", self.lastName, [self.firstName substringToIndex:1]];
    }
    return [NSString stringWithFormat:@"%@ %@.%@.", self.lastName, [self.firstName substringToIndex:1], [self.middleName substringToIndex:1]];
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

- (void)removeAllDeclarations
{
    [self.declarationsStorage removeAllObjects];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Name: %@", self.fullName];
}

@end
