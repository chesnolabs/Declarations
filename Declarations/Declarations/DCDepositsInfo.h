//
//  DCDepositsInfo.h
//  Declarations
//
//  Created by tanlan on 5/27/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCValue;

@interface DCDepositsInfo : NSObject

@property (strong) DCValue *bankDeposit_45_49;
@property (strong) DCValue *financialYearBankDeposit_46_50;
@property (strong) DCValue *securitiesNominalValue_47;
@property (strong) DCValue *financialYearSecuritiesNominalValue_48;
@property (strong) DCValue *shareCapitalDeposit_53;

@end
