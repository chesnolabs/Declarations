//
//  DCRealtyInfo.h
//  Declarations
//
//  Created by tanlan on 5/27/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCategory.h"

@class DCValue;

@interface DCRealtyInfo : DCCategory

@property (strong) DCValue *stead_23;
@property (strong) DCValue *house_24;
@property (strong) DCValue *flat_25;
@property (strong) DCValue *gardenHouse_26;
@property (strong) DCValue *garage_27;
@property (strong) DCValue *otherRealty_28;

+ (BOOL)containsValue:(NSString *)valueCode;

@end
