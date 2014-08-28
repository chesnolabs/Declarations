//
//  DCDeclarationsViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeclarationsViewController.h"
#import "DCDeclaration.h"
#import "DCDeclarationViewController.h"
#import "DCDataLoader.h"

@interface DCDeclarationsViewController ()

@property (strong) UIActivityIndicatorView *indicator;

@end

@implementation DCDeclarationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.deputy.fullName;
    
    DCDataLoader *loader = [DCDataLoader new];
    [loader loadDataForPerson:self.deputy completionHandler:^(BOOL success)
     {
         if (success)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.indicator stopAnimating];
                 [self.indicator setHidden:YES];
             });
             
             NSLog(@"Succeded in loading declaration %@", self.deputy.declarations);
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 [self.tableView reloadData];
             }];
         }
     }];
    
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

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (IBAction)cancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deputy.declarations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DeclarationIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	DCDeclaration *declaration = (self.deputy.declarations)[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Декларація за %@ рік", declaration.title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCDeclaration *declaration = (self.deputy.declarations)[indexPath.row];
    [self performSegueWithIdentifier:@"DeclarationDataSegue" sender:declaration];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DeclarationDataSegue"])
    {
        ((DCDeclarationViewController *)segue.destinationViewController).declaration = self.deputy.declarations[[self.tableView indexPathForCell:sender].row];
    }
}

@end
