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

@property (strong) NSMutableDictionary *sections;

@property (strong) UIActivityIndicatorView *indicator;

@end

@implementation DCDeputyViewController

- (void)loadPersons
{
    DCDataLoader *loader = [[DCDataLoader alloc] init];
    [loader loadPersonsWithCompletionHandler:^(NSArray *persons) {
        if (persons != nil)
        {
            self.deputies = [persons mutableCopy];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.indicator stopAnimating];
            [self.indicator setHidden:YES];
            
            self.displayedDeputies = self.deputies;
            [self generateSections];
            
            [self.tableView reloadData];
        }];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPersons];
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:
                                          CGRectMake(self.view.bounds.size.width / 2.0 - 12,
                                                     self.view.bounds.size.width / 2.0 - 12,
                                                     24, 24)];
    self.indicator.color = [UIColor blackColor];
    
    [self.indicator startAnimating];
    [self.view addSubview:self.indicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDeclarationsForDeputy:(DCPerson *)aDeputy
{
    [self performSegueWithIdentifier:@"DeclarationSegue" sender:aDeputy];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DeclarationSegue"])
    {
        ((DCDeclarationsViewController *)segue.destinationViewController).deputy = sender;
    }
}

- (void)generateSections
{
    BOOL found;
    
    self.sections = [NSMutableDictionary new];
    // Loop through the books and create our keys
    for (DCPerson *person in self.displayedDeputies)
    {
        NSString *c = [person.lastName substringToIndex:1];
        
        found = NO;
        
        for (NSString *str in [self.sections allKeys])
        {
            if ([str isEqualToString:c])
            {
                found = YES;
            }
        }
        
        if (!found)
        {
            [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
        }
    }
    
    // Loop again and sort the books into their respective keys
    for (DCPerson *person in self.displayedDeputies)
    {
        [[self.sections objectForKey:[person.lastName substringToIndex:1]] addObject:person];
    }
}

#pragma mark - Table View delegatep

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DeputyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    DCPerson *deputy = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

    cell.textLabel.text = deputy.fullName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDeclarationsForDeputy:self.displayedDeputies[indexPath.row]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections.allKeys count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sections.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)][section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.sections.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
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
    [self generateSections];
    [self.tableView reloadData];
}

@end
