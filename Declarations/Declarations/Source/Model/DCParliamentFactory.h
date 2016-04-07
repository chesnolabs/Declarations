//
//  DCParliamentFactory.h
//  Declarations
//
//  Created by Vera Tkachenko on 1/7/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCParliament;
@class DCKindOfCandidate;

@interface DCParliamentFactory : NSObject
@property (nonatomic, readonly) NSArray *parliaments;       //[DCParliament]
@property (nonatomic, readonly) NSArray *kindsOfCandidates; //[DCKindOfCandidate]

+ (instancetype)sharedInstance;

- (DCParliament *)parliamentWithConvocation:(NSUInteger)convocationNumber;
- (DCKindOfCandidate *)kindOfCandidatesWithTitle:(NSString *)title;

@end
