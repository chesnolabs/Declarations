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
#import "DCValueTransformer.h"

@interface DCCategoryViewController ()

@property (strong) DCValueTransformer *valueTransformer;

@end

@implementation DCCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = self.category.name;
    self.valueTransformer = [DCValueTransformer new];
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
        static NSString *CellIdentifier = @"CarValueIdentifier";
        DCVehicleTableViewCell *cell = (DCVehicleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     
        DCVehicle *vehicle = (DCVehicle *)value;
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
        cell.valueLabel.text = [self.valueTransformer transformedValue:value];
        
        return cell;
    }
    
    return nil;
}

@end
