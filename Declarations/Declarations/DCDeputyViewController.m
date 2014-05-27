//
//  DCFirstViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeputyViewController.h"
#import "DCPerson.h"
#import "DCDeclarationsViewController.h"
#import "DCDataLoader.h"

@interface DCDeputyViewController ()

@property (strong) NSMutableArray *deputies;
@property (strong) NSArray *displayedDeputies;

@end

@implementation DCDeputyViewController

- (void)loadPersons
{
    DCDataLoader *loader = [[DCDataLoader alloc] init];
    NSArray *persons = [loader loadPersons];
    if (persons != nil)
    {
        self.deputies = [persons mutableCopy];
    }
    
    self.displayedDeputies = self.deputies;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPersons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDeclarationsForDeputy:(DCPerson *)aDeputy
{
//    DCDataLoader *loader = [DCDataLoader new];
//    [loader loadDataForPerson:aDeputy completionHandler:^(BOOL success)
//    {
//        if (success)
//        {
//            [self performSegueWithIdentifier:@"DeclarationSegue" sender:aDeputy];
//        }
//    }];
    [self performSegueWithIdentifier:@"DeclarationSegue" sender:aDeputy];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DeclarationSegue"])
    {
        ((DCDeclarationsViewController *)segue.destinationViewController).deputy = sender;
    }
}

#pragma mark - Table View delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.displayedDeputies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DeputyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	DCPerson *deputy = (self.displayedDeputies)[indexPath.row];
    cell.textLabel.text = deputy.fullName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDeclarationsForDeputy:self.displayedDeputies[indexPath.row]];
}

#pragma mark - Search

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterResultsUsingString:searchText];
}

- (void)filterResultsUsingString:(NSString *)filterString
{
    if ([filterString length] == 0)
    {
        self.displayedDeputies = self.deputies;
    }
    else
    {
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"self.fullName CONTAINS[cd] %@", filterString];
        NSArray *filteredDeputies = [self.deputies filteredArrayUsingPredicate:filterPredicate];
        self.displayedDeputies = filteredDeputies;
    }
    [self.tableView reloadData];
}

@end
