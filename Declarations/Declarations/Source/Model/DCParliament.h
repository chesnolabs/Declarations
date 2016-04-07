//
//  DCParliament.h
//  Declarations
//
//  Created by Vera Tkachenko on 1/7/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import "DCArrayModel.h"

@class DCPerson;

@interface DCParliament : DCArrayModel
@property   NSUInteger    convocationNumber;
@property   NSDate        *startDate;
@property   NSDate        *endDate;

@end
