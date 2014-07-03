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

@property (nonatomic) NSNumberFormatter *formatter;

@end

@implementation DCCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = self.category.name;
}

- (NSNumberFormatter *)formatter
{
    if (!_formatter)
    {
        _formatter = [NSNumberFormatter new];
        _formatter.numberStyle = NSNumberFormatterCurrencyStyle;
        _formatter.locale = [NSLocale localeWithLocaleIdentifier:@"ua"];
        _formatter.positiveFormat = @"#,##0.00 грн";
    }
    return _formatter;
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
            cell.valueLabel.text = [self.formatter stringForObjectValue:value.value];
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
