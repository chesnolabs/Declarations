//
//  DCCategory.m
//  Declarations
//
//  Created by Vera Tkachenko on 6/25/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCCategory.h"
#import "DCVehicle.h"

@interface DCCategory ()

@property (strong) NSMutableArray *valuesStorage;
@property (assign) CGFloat totalFloatValue;

@end

@implementation DCCategory

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.icon = [UIImage imageNamed:@"Finance"];
        self.valuesStorage = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)values
{
    return self.valuesStorage;
}

- (void)addValue:(DCValue *)value
{
    if (value)
    {
        [self.valuesStorage addObject:value];
        
        if ([value isKindOfClass:[DCVehicle class]])
        {
            self.totalFloatValue ++;
        }
        else
        {
            self.totalFloatValue += [[value value] floatValue];
        }
    }
}

- (DCValue *)totalValue
{
    if (_totalValue == nil)
    {
        _totalValue = [[DCValue alloc] initWithCode:nil value:@( self.totalFloatValue ) title:nil units:self.unit];
    }
    return _totalValue;
}

@end
