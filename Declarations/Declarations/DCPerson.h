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

- (id)initWithJSONObject:(NSDictionary *)jsonObject;

@property (readonly) NSString *fullName;
@property (strong) NSString *firstName;
@property (strong) NSString *lastName;
@property (strong) NSString *middleName;
@property (assign) NSUInteger identifier;

@property (readonly) NSArray *declarations;

- (void)addDeclaration:(DCDeclaration *)aDeclaration;

@end
