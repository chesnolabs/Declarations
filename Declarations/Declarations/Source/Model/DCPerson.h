//
//  DCDeputy.h
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCDeclaration.h"

@interface DCPerson : NSObject
@property (readonly)    NSString    *fullName;
@property (strong)      NSString    *firstName;
@property (strong)      NSString    *lastName;
@property (strong)      NSString    *middleName;
@property (assign)      NSUInteger  identifier;

@property (nonatomic, readonly) NSArray     *parliaments;
@property (nonatomic, readonly) NSArray     *declarations;
@property (nonatomic, readonly) NSArray     *kindsOfCandidate;

- (instancetype)initWithJSONObject:(NSDictionary *)jsonObject;

- (void)addDeclaration:(DCDeclaration *)aDeclaration;
- (void)removeAllDeclarations;

@end
