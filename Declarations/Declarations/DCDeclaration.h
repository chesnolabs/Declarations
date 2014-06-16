//
//  DCDeclaration.h
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCGeneralInfo;
@class DCProfitInfo;
@class DCRealtyInfo;
@class DCVehiclesInfo;
@class DCDepositsInfo;
@class DCFinancialLiabilities;

@interface DCDeclaration : NSObject

- (id)initWithJSONObject:(NSDictionary *)jsonObject;

@property (strong, nonatomic) NSString *title;
@property (assign) NSUInteger year;
@property (strong) NSURL *linkToSource;
@property (strong) NSDictionary *data;
@property (assign) NSUInteger declarationID;
@property (strong) NSString *comment;
@property (strong) NSURL *originalURL;

@property (strong) DCGeneralInfo *generalInfo;
@property (strong) DCProfitInfo *profit;
@property (strong) DCRealtyInfo *realty;
@property (strong) DCVehiclesInfo *vehicles;
@property (strong) DCDepositsInfo *deposit;
@property (strong) DCFinancialLiabilities *fLiabilities;

@end
