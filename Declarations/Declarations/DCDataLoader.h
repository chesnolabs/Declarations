//
//  DCCommutator.h
//  Declarations
//
//  Created by tanlan on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  DCPerson;

@interface DCDataLoader : NSObject

- (NSArray *)loadPersons;
- (void)loadDataForPerson:(DCPerson *)person;

@end
