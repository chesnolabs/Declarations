//
//  DCDeclarationCategoryViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 6/29/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCCategoryViewController.h"
#import "DCValueCellView.h"
#import "DCCategory.h"

@implementation DCCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = self.category.name;
}

#pragma mark - TableView datasource/delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.category.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ValueIdentifier";
    DCValueCellView *cell = (DCValueCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	DCValue *value = (self.category.values)[indexPath.row];
    cell.titleLabel.text = value.title;
    cell.valueLabel.text = [NSString stringWithFormat:@"%@ %@", value.value, value.units];
    
    return cell;
}

@end
