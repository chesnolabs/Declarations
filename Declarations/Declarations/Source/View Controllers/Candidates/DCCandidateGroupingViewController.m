//
//  DCDeputiesGroupingViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 1/11/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import "DCCandidateGroupingViewController.h"
#import "LGMRomanNumber.h"
#import "DCParliamentFactory.h"
#import "DCParliament.h"

@interface DCCandidateGroupingViewController ()

@property UINavigationBar *navigationBar;

@end

@implementation DCCandidateGroupingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Категорії";
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *doneItem = [UIBarButtonItem new];
    doneItem.title = @"Готово";
    doneItem.action = @selector(doneAction:);
    doneItem.target = self;
    
    self.navigationItem.rightBarButtonItem = doneItem;
    
    [self.view addSubview:_navigationBar];
    [self.navigationBar pushNavigationItem:self.navigationItem animated:NO];
}

-(void)layoutNavigationBar
{
    self.navigationBar.frame = CGRectMake(0, self.tableView.contentOffset.y, self.tableView.frame.size.width, self.topLayoutGuide.length + 44);
    self.tableView.contentInset = UIEdgeInsetsMake(self.navigationBar.frame.size.height, 0, 0, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // no need to call super
    [self layoutNavigationBar];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.deputyViewController updateWithSelectedParliament:self.selectedParliaments];
    }];
}

#pragma mark - Table View delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ParliamentIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    DCParliament *parliament = [DCParliamentFactory sharedInstance].parliaments[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Парламент %@ скликання", [LGMRomanNumber romanFromArabic:parliament.convocationNumber]];
    
    cell.accessoryType = [self.selectedParliaments containsObject:parliament] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DCParliamentFactory sharedInstance].parliaments.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCParliament *parliament = [DCParliamentFactory sharedInstance].parliaments[indexPath.row];
    if ([self.selectedParliaments containsObject:parliament])
    {
        [self.selectedParliaments removeObject:parliament];
    }
    else
    {
        [self.selectedParliaments addObject:parliament];
    }
    [tableView reloadData];
}

@end
