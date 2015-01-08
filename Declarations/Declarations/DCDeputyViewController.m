//
//  DCFirstViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeputyViewController.h"
#import "DCPerson.h"
#import "DCParliament.h"
#import "DCParliamentFactory.h"
#import "DCDeclarationsViewController.h"
#import "DCDataLoader.h"
#import "LGMRomanNumber.h"

@interface DCDeputyViewController ()

@property (strong) NSMutableArray *deputies;
@property (strong) NSArray *parliaments;
@property (strong) NSArray *displayedDeputies;

@property (strong) NSMutableDictionary *sections;

@property (strong) UIActivityIndicatorView *indicator;

@property (assign, getter=isGroupedByParliaments) BOOL groupedByParliaments;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation DCDeputyViewController

- (void)loadPersons
{
    if (!self.indicator)
    {
        self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:
                          CGRectMake(self.view.bounds.size.width / 2.0 - 12,
                                     self.view.bounds.size.height / 2.0 - 12,
                                     24, 24)];
        self.indicator.color = [UIColor blackColor];
        
        [self.view addSubview:self.indicator];
    }
    
    [self.indicator startAnimating];
    self.indicator.hidden = NO;

    
    DCDataLoader *loader = [[DCDataLoader alloc] init];
    [loader loadDeputiesWithCompletionHandler:^(NSArray *persons, NSError *error) {
        if (persons != nil)
        {
            [self processPersons:persons];
        }
        else
        {
            [self showError:error];
        }
    }];
}

- (void)showError:(NSError *)error
{
    UIAlertView *alert = [UIAlertView new];
    alert.title = @"Неможливо завантажити данні.";
    alert.message = @"Можливо відсутній Інтернет. Спробуйте пізніше.";
    alert.delegate = self;
    [alert addButtonWithTitle:@"Спробувати"];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [alert show];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self loadPersons];
}

- (void)processPersons:(NSArray *)persons
{
    if (persons != nil)
    {
        self.deputies = [persons mutableCopy];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.indicator stopAnimating];
            [self.indicator setHidden:YES];
            
            self.displayedDeputies = self.deputies;

            DCParliamentFactory *parliamentFactory = [DCParliamentFactory sharedInstance];
            for (DCPerson *deputy in self.deputies)
            {
                for (NSNumber *convocationNumber in deputy.parliaments)
                {
                    DCParliament *parliament = [parliamentFactory parliamentWithConvocation:convocationNumber.integerValue];
                    [parliament addDeputy:deputy];
                }
            }
            
            self.parliaments = parliamentFactory.parliaments;
            
            [self generateSections];
            
            [self.tableView reloadData];
        }];
    }
    else
    {
    }
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

- (DCPerson *)deputyAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
}

#pragma mark - Table View delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isGroupedByParliaments)
    {
        static NSString *CellIdentifier = @"ParliamentIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        DCParliament *parliament = self.parliaments[indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"Парламент %@ скликання", [LGMRomanNumber romanFromArabic:parliament.convocationNumber]];
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"DeputyIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        DCPerson *deputy = [self deputyAtIndexPath:indexPath];

        cell.textLabel.text = deputy.fullName;

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDeclarationsForDeputy:[self deputyAtIndexPath:indexPath]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.isGroupedByParliaments ? 1 : [self.sections.allKeys count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.isGroupedByParliaments ? nil : [self.sections.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)][section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.isGroupedByParliaments ? nil : [self.sections.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.isGroupedByParliaments ? self.parliaments.count : [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
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

- (IBAction)changeGroupingAction:(UISegmentedControl *)sender
{
    self.groupedByParliaments = sender.selectedSegmentIndex == 1;
    [self.searchBar removeFromSuperview];//.hidden = self.isGroupedByParliaments;
    CGRect frame = self.tableView.frame;
    frame.size.height += self.searchBar.frame.size.height;
    self.tableView.frame = frame;
    [self.tableView reloadData];
}

@end
