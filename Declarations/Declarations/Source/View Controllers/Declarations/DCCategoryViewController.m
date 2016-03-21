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

const static CGFloat kDCDefaultRowHeight = 60.0;

@implementation DCCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = self.category.name;
    self.valueTransformer = [DCValueTransformer new];
}

#pragma mark - TableView datasource/delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = (indexPath.section == 0 ? self.category.values : self.category.familyValues);
    
    if (array.count == 0)
    {
        return kDCDefaultRowHeight;
    }
    
    DCValue *value = array[indexPath.row];
    if (!value.title || [value isKindOfClass:[DCVehicle class]])
    {
        return kDCDefaultRowHeight;
    }
    
    static NSString *CellIdentifier = @"ValueIdentifier";
    DCValueCellView *cell = (DCValueCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CGSize constrainedSize = CGSizeMake(cell.titleLabel.frame.size.width, 9999);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0], NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:value.title attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    if (requiredHeight.size.width > cell.titleLabel.frame.size.width) {
        requiredHeight = CGRectMake(0, 0, cell.titleLabel.frame.size.width, requiredHeight.size.height);
    }
    
    return kDCDefaultRowHeight + requiredHeight.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @"Декларанта" : @"Сім'ї декларанта";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = section == 0 ? self.category.values.count : self.category.familyValues.count;
    return numberOfRows ?: 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = (indexPath.section == 0 ? self.category.values : self.category.familyValues);
    
    if (array.count == 0)
    {
        static NSString *CellIdentifier = @"EmptyValueIdentifier";
        return [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    DCValue *value = array[indexPath.row];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 30.0 : 15.0;
}

@end
