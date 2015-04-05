//
//  DCParliament.h
//  Declarations
//
//  Created by Vera Tkachenko on 1/7/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPerson.h"

@interface DCParliament : NSObject

@property (readonly) NSArray *deputies;
- (void)addDeputy:(DCPerson *)deputy;

@property NSUInteger convocationNumber;
@property NSDate *startDate;
@property NSDate *endDate;

@end
