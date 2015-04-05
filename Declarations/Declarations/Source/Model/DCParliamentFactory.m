//
//  DCParliamentFactory.m
//  Declarations
//
//  Created by Vera Tkachenko on 1/7/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import "DCParliamentFactory.h"

@interface DCParliamentFactory ()

@property NSMutableDictionary *paliamentsMap;

@end

@implementation DCParliamentFactory

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _paliamentsMap = [NSMutableDictionary new];
    }
    return self;
}

- (DCParliament *)parliamentWithConvocation:(NSUInteger)convocationNumber
{
    DCParliament *parliament = self.paliamentsMap[@(convocationNumber)];
    if (parliament == nil)
    {
        parliament = [DCParliament new];
        parliament.convocationNumber = convocationNumber;
        self.paliamentsMap[@(convocationNumber)] = parliament;
    }
    return parliament;
}

- (NSArray *)parliaments
{
    return self.paliamentsMap.allValues;
}

@end
