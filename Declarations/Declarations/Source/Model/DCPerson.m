//
//  DCDeputy.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCPerson.h"
#import "DCParliamentFactory.h"
#import "DCParliament.h"
#import "DCKindOfCandidate.h"

@interface DCPerson ()
@property (strong) NSMutableArray *declarationsStorage;
@property (strong) NSMutableArray *parliamentsStorage;
@property (strong) NSMutableArray *kindsOfCandidatesStorage;

@end

@implementation DCPerson

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithJSONObject:(NSDictionary *)jsonObject {
    self = [super init];
    if (self) {
        self.declarationsStorage = [NSMutableArray array];
        self.parliamentsStorage = [NSMutableArray array];

        id lastNameJson = jsonObject[@"last_name"];
        if (lastNameJson == [NSNull null] ||
            ![lastNameJson isKindOfClass:[NSString class]] ||
            ([lastNameJson isKindOfClass:[NSString class]] && ((NSString *)lastNameJson).length == 0)) {
            
            NSLog(@"Failed to create person from JSON %@", jsonObject);
            
            return nil;
        }

        self.lastName = jsonObject[@"last_name"];
        if (jsonObject[@"first_name"] != [NSNull null]) {
            self.firstName = jsonObject[@"first_name"];
        }
        
        if (jsonObject[@"second_name"] != [NSNull null]) {
            self.middleName = jsonObject[@"second_name"];
        }
        
        NSString *stringIdentifier = jsonObject[@"id"];
        self.identifier = [stringIdentifier integerValue];
        
        if (jsonObject[@"convocations"] != [NSNull null]) {
            NSArray *parliamentsNumbers = jsonObject[@"convocations"];
            for (NSNumber *number in parliamentsNumbers) {
                DCParliament *parliament = [[DCParliamentFactory sharedInstance]
                                            parliamentWithConvocation:number.integerValue];
                [parliament addModel:self];
                [self.parliamentsStorage addObject:parliament];
            }
        }
        
#warning! When API will be changed, get kind of candidate from JSON
        NSString *kind = @"Кандидати в Президенти 2014 р.";
        DCKindOfCandidate *kindOfCandidate = [[DCParliamentFactory sharedInstance] kindOfCandidatesWithTitle:kind];
        
        [kindOfCandidate addModel:self];
        [self.kindsOfCandidatesStorage addObject:kindOfCandidate];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    if (self.firstName.length == 0) {
        return [NSString stringWithFormat:@"%@", self.lastName];
    }
    
    if (self.middleName.length == 0) {
        return [NSString stringWithFormat:@"%@ %@.", self.lastName, [self.firstName substringToIndex:1]];
    }
    
    return [NSString stringWithFormat:@"%@ %@.%@.", self.lastName, [self.firstName substringToIndex:1], [self.middleName substringToIndex:1]];
}

- (NSArray *)declarations {
    @synchronized(self.declarationsStorage) {
        return [self.declarationsStorage copy];
    }
}

- (NSArray *)parliaments {
    @synchronized(self.parliamentsStorage) {
        return [self.parliamentsStorage copy];
    }
}

- (NSArray *)kindsOfCandidate {
    @synchronized(self.kindsOfCandidatesStorage) {
        return [self.kindsOfCandidatesStorage copy];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@", self.fullName];
}

#pragma mark -
#pragma mark Public

- (void)addDeclaration:(DCDeclaration *)aDeclaration {
    if (aDeclaration != nil) {
        [self.declarationsStorage addObject:aDeclaration];
        aDeclaration.person = self;
    }
}

- (void)removeAllDeclarations {
    [self.declarationsStorage removeAllObjects];
}

@end
