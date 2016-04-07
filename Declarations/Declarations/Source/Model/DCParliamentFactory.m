//
//  DCParliamentFactory.m
//  Declarations
//
//  Created by Vera Tkachenko on 1/7/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import "DCParliamentFactory.h"
#import "DCParliament.h"
#import "DCKindOfCandidate.h"

@interface DCParliamentFactory ()
@property NSMutableDictionary *paliamentsMap;
@property NSMutableDictionary *kindsOfCandidatesMap;

@end

@implementation DCParliamentFactory

#pragma mark -
#pragma mark Singleton

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

#pragma mark -
#pragma mark Initializations and Deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        _paliamentsMap = [NSMutableDictionary new];
        _kindsOfCandidatesMap = [NSMutableDictionary new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)parliaments {
    return self.paliamentsMap.allValues;
}

- (NSArray *)kindsOfCandidates {
    return self.kindsOfCandidatesMap.allValues;
}

#pragma mark -
#pragma mark Public

- (DCParliament *)parliamentWithConvocation:(NSUInteger)convocationNumber {
    DCParliament *parliament = self.paliamentsMap[@(convocationNumber)];
    if (parliament == nil) {
        parliament = [DCParliament model];
        parliament.convocationNumber = convocationNumber;
        self.paliamentsMap[@(convocationNumber)] = parliament;
    }
    
    return parliament;
}

- (DCKindOfCandidate *)kindOfCandidatesWithTitle:(NSString *)title {
    DCKindOfCandidate *kindOfCandidates = self.kindsOfCandidatesMap[title];
    if (kindOfCandidates == nil) {
        kindOfCandidates = [DCKindOfCandidate model];
        kindOfCandidates.title = title;
        self.kindsOfCandidatesMap[title] = kindOfCandidates;
    }
    
    return kindOfCandidates;
}

@end
