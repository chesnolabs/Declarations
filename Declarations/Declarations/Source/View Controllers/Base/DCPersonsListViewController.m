//
//  DCPersonsListViewController.m
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "DCPersonsListViewController.h"
#import "DCPersonsListView.h"
#import "DCScopeCollectionViewCell.h"
#import "DCPersonTableViewCell.h"
#import "DCPersonListHeaderView.h"

#import "DCPerson.h"
#import "DCParliament.h"
#import "DCParliamentFactory.h"
#import "DCDeclarationsViewController.h"
#import "DCDataLoader.h"

#import "AFSwipeToHide.h"

#import "UITableView+DCTableViewCategory.h"
#import "UIView+MILoadingViewCategory.h"
#import "DCPropertyMacros.h"

static const CGFloat kDCMinScopeBarItemWidth = 150.0;

@interface DCPersonsListViewController ()   <AFSwipeToHideDelegate>
@property (strong) NSMutableArray       *persons;
@property (strong) NSArray              *displayedDeputies;
@property (strong) NSMutableDictionary  *sections;
@property          NSMutableArray       *selectedScopeItems;

@property (nonatomic, assign)   CGFloat             scopeBarItemWidth;

@property (nonatomic, readonly) DCPersonsListView    *rootView;
@property (nonatomic, strong)   AFSwipeToHide        *swipeToHide;

- (void)loadPersons;
- (void)filterResultsUsingString:(NSString *)filterString;
- (void)generateSections;
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath;
- (DCPerson *)personAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation DCPersonsListViewController

#pragma mark -
#pragma mark Accessors

DCViewControllerViewOfClassGetterSynthesize(DCPersonsListView, rootView);

#pragma mark -
#pragma mark Accessors

- (Class)tableViewCellClass {
    return [DCPersonTableViewCell class];
}

- (Class)collectionViewCellClass {
    return [DCScopeCollectionViewCell class];
}

- (NSArray *)scopeModel {
    return @[];
}

- (NSUInteger)startingIndex {
    return 0;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedScopeItems = [NSMutableArray array];
    
    [self loadPersons];
    
#warning! remove it to title for navigation backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    
    //add swipeToHide
    DCPersonsListView *rootView = self.rootView;
    AFSwipeToHide *swipeToHide = [AFSwipeToHide new];
    swipeToHide.scrollDistance = CGRectGetHeight(rootView.headerView.bounds);
    swipeToHide.delegate = self;
    
    self.swipeToHide = swipeToHide;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        UICollectionView *collectionView = self.rootView.scopeBarCollectionView;
        [collectionView.collectionViewLayout invalidateLayout];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.startingIndex inSection:0];
        if ([collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
            [collectionView scrollToItemAtIndexPath:indexPath
                                   atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                           animated:YES];
        }
    }
                                 completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         
     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.rootView endEditing:YES];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sections.allKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCPersonTableViewCell *cell = [tableView reusableCellWithClass:self.tableViewCellClass];
    DCPerson *person = [self personAtIndexPath:indexPath];
    
    [cell fillWithModel:person];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.sections.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DCPersonListHeaderView *view = [DCPersonListHeaderView headerView];
    NSString *sectionTitle = [self.sections.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)][section];
    
    [view fillWithString:sectionTitle];
    
    return view;
}

#pragma mark - TableView Delegate
- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //hide keyboard
    [self.rootView endEditing:YES];
    
    //show declarations for selected person
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DCPerson *deputy = [self personAtIndexPath:indexPath];
    DCDeclarationsViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DCDeclarationsViewController"];
    controller.deputy = deputy;
    [self.navigationController pushViewController:controller animated:true];
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [self.scopeModel count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCScopeCollectionViewCell *cell = [collectionView
                                       dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.collectionViewCellClass)
                                                                 forIndexPath:indexPath];
    NSArray *scopeModel = self.scopeModel;
    DCArrayModel *model = [scopeModel objectAtIndex:indexPath.item];
    
    [cell fillWithModel:model];
    
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegate

- (void)        collectionView:(UICollectionView *)collectionView
      didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCPersonsListView *rootView = self.rootView;
    [rootView endEditing:YES];
    
    NSArray *scopeModel = self.scopeModel;
    DCArrayModel *arrayModel = [scopeModel objectAtIndex:indexPath.row];
    [self.selectedScopeItems addObject:arrayModel];
    
    //scroll selected item to center
    [rootView.scopeBarCollectionView scrollToItemAtIndexPath:indexPath
                                            atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                    animated:YES];
    
    //filter persons (by convocation || by kind of candidate)
    [self filterResultsUsingString:self.rootView.searchBar.text];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    DCPersonsListView *rootView = self.rootView;
    [rootView endEditing:YES];
    
    NSArray *scopeModel = self.scopeModel;
    DCArrayModel *arrayModel = [scopeModel objectAtIndex:indexPath.row];
    
    [self.selectedScopeItems removeObject:arrayModel];
    
    [self filterResultsUsingString:rootView.searchBar.text];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.swipeToHide beginDragAtPosition:scrollView.contentOffset.y + scrollView.contentInset.top];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat position = targetContentOffset->y + scrollView.contentInset.top;
    [self.swipeToHide endDragAtTargetPosition:position
                                     velocity:velocity.y];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.swipeToHide scrollToPosition:scrollView.contentOffset.y + scrollView.contentInset.top];
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat baseCellWidth = CGRectGetWidth([UIScreen mainScreen].bounds) / [self.scopeModel count];
    CGFloat cellWidth = baseCellWidth > kDCMinScopeBarItemWidth ? baseCellWidth : kDCMinScopeBarItemWidth;
    self.scopeBarItemWidth = cellWidth;
    
    return CGSizeMake(cellWidth, CGRectGetHeight(collectionView.frame));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    CGFloat width = self.scopeBarItemWidth;
    CGFloat inset = width > kDCMinScopeBarItemWidth ? 0 : (CGRectGetWidth([UIScreen mainScreen].bounds) - width) / 2.0;
    
    return UIEdgeInsetsMake(0.0, inset, 0.0, inset);
}

#pragma mark - SearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterResultsUsingString:searchText];
}

#pragma mark -
#pragma mark AFSwipeToHide delegate

- (void)swipeToHide:(AFSwipeToHide *)swipeToHide didUpdatePercentHiddenInteractively:(BOOL)interactive {
    DCPersonsListView *rootView = self.rootView;
    CGFloat percentHidden = swipeToHide.percentHidden;
    CGFloat alpha = 1.0 - percentHidden;
    rootView.searchBar.alpha = alpha;
    rootView.scopeBarCollectionView.alpha = alpha;
    
    rootView.scopeBarTopSpace.constant = -percentHidden * CGRectGetHeight(rootView.headerView.bounds);
    
    if (!interactive) {
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.7
                            options:0
                         animations:^
        {
            [rootView setNeedsLayout];
            [rootView layoutIfNeeded];
        }
                         completion:nil];
    }
}

#pragma mark -
#pragma mark Private

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionView *collectionView = self.rootView.scopeBarCollectionView;
    
    [collectionView cellForItemAtIndexPath:indexPath].selected = YES;
    
    [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:0];
}

- (DCPerson *)personAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
}

- (void)loadPersons {
    
}

- (void)filterResultsUsingString:(NSString *)filterString {
    NSMutableArray *selectedScopeItems = self.selectedScopeItems;
    NSArray *scopeModel = self.scopeModel;
    if (0 == filterString.length &&
        (selectedScopeItems.count == scopeModel.count || 0 == selectedScopeItems.count))
    {
        self.displayedDeputies = self.persons;
    } else {
        NSArray *personsFilteredByName = self.persons;
        if (0 != filterString.length) {
            NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"self.fullName CONTAINS[cd] %@", filterString];
            personsFilteredByName = [self.displayedDeputies filteredArrayUsingPredicate:filterPredicate];
        }
        
        if (selectedScopeItems.count != scopeModel.count && selectedScopeItems.count > 0) {
            NSMutableArray *personsFilteredByScope = [NSMutableArray new];
            for (DCPerson *person in personsFilteredByName) {
                for (DCArrayModel *arrayModel in selectedScopeItems) {
                    if ([arrayModel containsObject:person]) {
                        [personsFilteredByScope addObject:person];
                        
                        break;
                    }
                }
            }
            
            self.displayedDeputies = personsFilteredByScope;
        } else {
            self.displayedDeputies = personsFilteredByName;
        }
    }
    
    [self generateSections];
    
    [self.rootView.tableView reloadData];
}

- (void)generateSections {
    BOOL found;
    
    self.sections = [NSMutableDictionary new];
    // Loop through the books and create our keys
    for (DCPerson *person in self.displayedDeputies) {
        NSString *c = [person.lastName substringToIndex:1];
        
        found = NO;
        
        for (NSString *str in [self.sections allKeys]) {
            if ([str isEqualToString:c]) {
                found = YES;
            }
        }
        
        if (!found) {
            [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
        }
    }
    
    // Loop again and sort the books into their respective keys
    for (DCPerson *person in self.displayedDeputies) {
        [[self.sections objectForKey:[person.lastName substringToIndex:1]] addObject:person];
    }
}

#pragma mark -
#pragma mark Public

- (void)processPersons:(NSArray *)persons {
    if (persons != nil) {
        self.persons = [persons mutableCopy];
        DCPersonsListView *rootView = self.rootView;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [rootView hideLoadingView];
            
            self.displayedDeputies = self.persons;
            
            [self generateSections];
            
            [rootView.tableView reloadData];
            
            //set scopeBar
            if ([self.scopeModel count] > 0) {
                if (1 == [self.scopeModel count]) {
                    rootView.scopeBarCollectionView.userInteractionEnabled = NO;
                }
                
                [rootView.scopeBarCollectionView reloadData];
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.startingIndex inSection:0];
                [self selectItemAtIndexPath:indexPath];
            }
        }];
    }
}

- (void)showError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Неможливо завантажити данні."
                                                                   message:@"Можливо відсутній Інтернет. Спробуйте пізніше."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Спробувати"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
    {
        [self loadPersons];
        [alert dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [alert addAction:dismissAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
