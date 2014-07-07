//
//  DCDeclarationCategoryViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 6/29/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCCategoryViewController.h"
#import "DCValueCellView.h"
#import "DCVehicleTableViewCell.h"
#import "DCCategory.h"
#import "DCVehicle.h"

@interface DCCategoryViewController ()

@property (nonatomic) NSNumberFormatter *currencyFormatter;
@property (nonatomic) NSNumberFormatter *areaFormatter;

@end

@implementation DCCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = self.category.name;
}

- (NSNumberFormatter *)currencyFormatter
{
    if (!_currencyFormatter)
    {
        _currencyFormatter = [NSNumberFormatter new];
        _currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        _currencyFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"ua"];
        _currencyFormatter.positiveFormat = @"#,##0.00 грн";
    }
    return _currencyFormatter;
}

- (NSNumberFormatter *)areaFormatter
{
    if (!_areaFormatter)
    {
        _areaFormatter = [NSNumberFormatter new];
        _areaFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
        _areaFormatter.maximumFractionDigits = 2;
        _areaFormatter.minimumFractionDigits = 2;
    }
    return _areaFormatter;
}

#pragma mark - TableView datasource/delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.category.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCValue *value = (self.category.values)[indexPath.row];
    
    if ([value isKindOfClass:[DCVehicle class]])
    {
        DCVehicle *vehicle = (DCVehicle *)value;
        static NSString *CellIdentifier = @"CarValueIdentifier";
        DCVehicleTableViewCell *cell = (DCVehicleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.fullModelLabel.text = [NSString stringWithFormat:@"%@ %@", vehicle.mark, vehicle.model];
        cell.yearLabel.text = vehicle.year;
        cell.engineLabel.text = vehicle.info;
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"ValueIdentifier";
        DCValueCellView *cell = (DCValueCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cell.titleLabel.text = value.title;
        // Just for now
        if ([value.units isEqualToString:@"грн"])
        {
            cell.valueLabel.text = [self.currencyFormatter stringForObjectValue:value.value];
        }
        else if ([value.units isEqualToString:@"кв. м."])
        {
            cell.valueLabel.text = [NSString stringWithFormat:@"%@ %@", [self.areaFormatter stringForObjectValue:value.value], value.units];
        }
        else
        {
            cell.valueLabel.text = [NSString stringWithFormat:@"%@ %@", value.value, value.units];
        }
        return cell;
    }
    
    return nil;
}

@end
