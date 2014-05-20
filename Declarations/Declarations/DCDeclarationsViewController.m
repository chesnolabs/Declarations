//
//  DCDeclarationsViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeclarationsViewController.h"
#import "DCDeclaration.h"

@implementation DCDeclarationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
	DCDeclarationsViewController *declaration = (self.deputy.declarations)[indexPath.row];
    cell.textLabel.text = declaration.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO
}

@end
