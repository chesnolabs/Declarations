//
//  DCDeputiesGroupingViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 1/11/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import "DCCandidateGroupingViewController.h"

@implementation DCCandidateGroupingViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ParliamentIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    DCParliament *parliament = [DCParliamentFactory sharedInstance].parliaments[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Кандидати в президенти"];
    //, [LGMRomanNumber romanFromArabic:parliament.convocationNumber]];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //[self.selectedParliaments containsObject:parliament] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    //[DCParliamentFactory sharedInstance].parliaments.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DCParliament *parliament = [DCParliamentFactory sharedInstance].parliaments[indexPath.row];
//    if ([self.selectedParliaments containsObject:parliament])
//    {
//        [self.selectedParliaments removeObject:parliament];
//    }
//    else
//    {
//        [self.selectedParliaments addObject:parliament];
//    }
//    [tableView reloadData];
}

@end
