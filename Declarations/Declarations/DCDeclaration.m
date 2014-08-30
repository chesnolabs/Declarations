//
//  DCDeclaration.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeclaration.h"
#import "DCVehiclesInfo.h"
#import "DCProfitInfo.h"
#import "DCDepositsInfo.h"
#import "DCFinancialLiabilities.h"
#import "DCRealtyInfo.h"
#import "DCValue.h"
#import "DCVehicle.h"

@interface DCDeclaration ()

@property (strong, readonly) NSDictionary *table;

@end

static NSString *const MHDeclarationYearKey = @"year";
static NSString *const MHDeclarationURLKey = @"url";
static NSString *const MHDeclarationIDKey = @"id";
static NSString *const MHDeclarationCommentKey = @"comment";
static NSString *const MHDeclarationFieldsKey = @"fields";

static NSString *const MHDeclarationsItemsKey = @"items";
static NSString *const MHDeclarationsValueKey = @"value";
static NSString *const MHDeclarationsUnitsKey = @"units";
static NSString *const DCDeclarationsTitleKey = @"title";

static NSString *const DCVehicleInfoKey = @"description";
static NSString *const DCVehicleMarkKey = @"mark";
static NSString *const DCVehicleModelKey = @"model";

@implementation DCDeclaration

@synthesize profit = _profit;

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        self.categories = @[ self.vehicles, self.profit, self.deposit, self.realty, self.financialLiabilities ];
    }
    
    return self;
}

- (id)initWithJSONObject:(NSDictionary *)jsonObject
{
    self = [self init];
    
    if (self != nil)
    {
        _table = @{ @"profit" : @{ @"from" : @( 6 ), @"to" : @( 22 )},
                    @"realty" : @{ @"from" : @( 23 ), @"to" : @( 34 )},
                    @"vehicles" : @{ @"from" : @( 35 ), @"to" : @( 44 )},
                    @"deposit" : @{ @"from" : @( 45 ), @"to" : @( 53 )},
                    @"financialLiabilities" : @{ @"from" : @( 54 ), @"to" : @( 64 )} };

         self.categories = @[ self.vehicles, self.profit, self.deposit, self.realty, self.financialLiabilities ];
        
        [self setupWithJSON:jsonObject];
    }
    
    return self;
}

- (void)setupWithJSON:(NSDictionary *)jsonObject
{
    _year = [[jsonObject objectForKey:MHDeclarationYearKey] integerValue];
    
    NSString *url = [jsonObject objectForKey:MHDeclarationURLKey];
    if (url != nil)
    {
        _originalURL = [NSURL URLWithString:[@"http://chesno.org" stringByAppendingString:url]];
    }
    
    NSDictionary *model = [jsonObject objectForKey:MHDeclarationFieldsKey];
    
    [model enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]] && [obj allKeys].count)
        {
            NSArray *items = [obj objectForKey:MHDeclarationsItemsKey];

            NSString *units = [obj objectForKey:MHDeclarationsUnitsKey];
            NSString *title = [obj objectForKey:DCDeclarationsTitleKey];
            
            for (id currentItem in items)
            {
                id value = [currentItem objectForKey:MHDeclarationsValueKey];
                
                __block NSString *foundCategory = nil;
                [self.table enumerateKeysAndObjectsUsingBlock:^(NSString *category, NSDictionary *range, BOOL *stop) {
                    if ([key floatValue] >= [range[@"from"] floatValue] && [key floatValue] <= [range[@"to"] floatValue])
                    {
                        foundCategory = category;
                        *stop = YES;
                    }
                }];
                
                if (foundCategory != nil)
                {
                    DCValue *newValue = nil;
                    
                    if ([foundCategory isEqualToString:@"vehicles"])
                    {
                        newValue = [[DCVehicle alloc] initWithCode:key
                                                              info:[currentItem objectForKey:DCVehicleInfoKey]
                                                              mark:[currentItem objectForKey:DCVehicleMarkKey]
                                                             model:[currentItem objectForKey:DCVehicleModelKey]
                                                              year:[currentItem objectForKey:MHDeclarationYearKey]];
                    }
                    else
                    {
                        newValue = [[DCValue alloc] initWithCode:key
                                                           value:value
                                                           title:title
                                                           units:units];
                    }
                    
                    DCCategory *category = [self valueForKey:foundCategory];
                    [category addValue:newValue];
                }
            }
        }
    }];
}

- (NSString *)title
{
    if (_title == nil)
    {
        _title = [NSString stringWithFormat:@"%lu", (unsigned long)self.year];

    }
    return _title;
}

#pragma mark - Categories

- (DCVehiclesInfo *)vehicles
{
    if (!_vehicles)
    {
        _vehicles = [DCVehiclesInfo new];
        _vehicles.name = @"Транспорт";
        _vehicles.icon = [UIImage imageNamed:@"Vehicle"];
    }
    return _vehicles;
}

- (DCProfitInfo *)profit
{
    if (!_profit)
    {
        _profit = [DCProfitInfo new];
        _profit.name = @"Дохід";
        _profit.icon = [UIImage imageNamed:@"Profit"];
    }
    return _profit;
}

- (DCDepositsInfo *)deposit
{
    if (!_deposit)
    {
        _deposit = [DCDepositsInfo new];
        _deposit.name = @"Депозити";
        _deposit.icon = [UIImage imageNamed:@"Deposit"];
    }
    return _deposit;
}

- (DCRealtyInfo *)realty
{
    if (!_realty)
    {
        _realty = [DCRealtyInfo new];
        _realty.name = @"Нерухомість";
        _realty.icon = [UIImage imageNamed:@"Realty"];
    }
    return _realty;
}

- (DCFinancialLiabilities *)financialLiabilities
{
    if (!_financialLiabilities)
    {
        _financialLiabilities = [DCFinancialLiabilities new];
        _financialLiabilities.icon = [UIImage imageNamed:@"Liability"];
        _financialLiabilities.name = @"Фінансові забов'язання";
    }
    return _financialLiabilities;
}

@end
