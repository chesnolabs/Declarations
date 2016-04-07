//
//  DCPersonsListView.h
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCPersonsListView : UIView
@property (nonatomic, strong) IBOutlet UISearchBar      *searchBar;
@property (nonatomic, strong) IBOutlet UITableView      *tableView;
@property (strong, nonatomic) IBOutlet UICollectionView *scopeBarCollectionView;
@property (strong, nonatomic) IBOutlet UIView           *headerView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scopeBarTopSpace;


@end
