//
//  DCProfitInfo.h
//  Declarations
//
//  Created by tanlan on 5/26/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCategory.h"

@class DCValue;

@interface DCProfitInfo : DCCategory

@property (strong) DCValue *totalProfit_5;
@property (strong) DCValue *laborSalary_6;
@property (strong) DCValue *teachingSalary_7;
@property (strong) DCValue *royalties_8;

@property (strong) DCValue *interest_9;
@property (strong) DCValue *financialAid_10;
@property (strong) DCValue *awards_11;

@property (strong) DCValue *dole_12;
@property (strong) DCValue *alimony_13;

@property (strong) DCValue *heritage_14;

@property (strong) DCValue *insuranceBenefits_15;
@property (strong) DCValue *alienationPropertyIncome_16;
@property (strong) DCValue *businessIncome_17;
@property (strong) DCValue *securitiesDisposalIncome_18;
@property (strong) DCValue *leaseIncome_19;
@property (strong) DCValue *otherIncome_20;
@property (strong) DCValue *foreignIncome_21;

@end
