//
//  DCValueTransformer.m
//  Declarations
//
//  Created by Vera Tkachenko on 8/28/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCValueTransformer.h"
#import "DCValue.h"

@implementation DCValueTransformer

+ (Class)transformedValueClass
{
	return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
	return NO;
}

static NSNumberFormatter *sDCCurrencyFormatter;
static NSNumberFormatter *sDCAreaFormatter;

- (NSNumberFormatter *)currencyFormatter
{
    if (!sDCCurrencyFormatter)
    {
        sDCCurrencyFormatter = [NSNumberFormatter new];
        sDCCurrencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        sDCCurrencyFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"ua"];
        sDCCurrencyFormatter.positiveFormat = @"#,##0.00 грн";
    }
    return sDCCurrencyFormatter;
}

- (NSNumberFormatter *)areaFormatter
{
    if (!sDCAreaFormatter)
    {
        sDCAreaFormatter = [NSNumberFormatter new];
        sDCAreaFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
        sDCAreaFormatter.maximumFractionDigits = 2;
        sDCAreaFormatter.minimumFractionDigits = 2;
    }
    return sDCAreaFormatter;
}

- (id)transformedValue:(id)aValue
{
	if (!aValue || ![aValue isKindOfClass:[DCValue class]])
	{
		return nil;
	}
    NSString *transformedValue = nil;
    DCValue *declarationValue = (DCValue *)aValue;
    if ([declarationValue.units isEqualToString:@"грн"])
    {
        transformedValue = [self.currencyFormatter stringForObjectValue:declarationValue.value];
    }
    else if ([declarationValue.units isEqualToString:@"кв. м."])
    {
        transformedValue = [NSString stringWithFormat:@"%@ %@", [self.areaFormatter stringForObjectValue:declarationValue.value], declarationValue.units];
    }
    else
    {
        transformedValue = [NSString stringWithFormat:@"%@ %@", declarationValue.value, declarationValue.units];
    }

    return transformedValue;
}

@end
