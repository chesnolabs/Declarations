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
        _table = @{ @"7.0" : @"profit.teachingSalary_7" };
        
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
        _originalURL = [NSURL URLWithString:url];
    }
    
    NSDictionary *model = [jsonObject objectForKey:MHDeclarationFieldsKey];
    
    [model enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *keyPath = [self.table objectForKey:key];
        if (keyPath != nil && [obj isKindOfClass:[NSDictionary class]] && [obj allKeys].count)
        {
            NSArray *items = [obj objectForKey:MHDeclarationsItemsKey];
            id value = [items[0] objectForKey:MHDeclarationsValueKey];
            
            DCValue *newValue = [[DCValue alloc] initWithCode:key
                                                        value:value
                                                        units:@""];
            
            [self setValue:newValue forKeyPath:keyPath];
            
            NSLog(@"test = %@", self.profit.teachingSalary_7);
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
        _vehicles.name = @"Авто";
    }
    return _vehicles;
}

- (DCProfitInfo *)profit
{
    if (!_profit)
    {
        _profit = [DCProfitInfo new];
        _profit.name = @"Дохід";
    }
    return _profit;
}

- (DCDepositsInfo *)deposit
{
    if (!_deposit)
    {
        _deposit = [DCDepositsInfo new];
        _deposit.name = @"Депозити";
    }
    return _deposit;
}

- (DCRealtyInfo *)realty
{
    if (!_realty)
    {
        _realty = [DCRealtyInfo new];
        _realty.name = @"Нерухомість";
    }
    return _realty;
}

- (DCFinancialLiabilities *)financialLiabilities
{
    if (!_financialLiabilities)
    {
        _financialLiabilities = [DCFinancialLiabilities new];
        _financialLiabilities.name = @"Фінансові забов'язання";
    }
    return _financialLiabilities;
}

@end
