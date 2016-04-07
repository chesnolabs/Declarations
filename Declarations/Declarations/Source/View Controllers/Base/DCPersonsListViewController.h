//
//  DCPersonsListViewController.h
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCPersonsListViewController : UIViewController   <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, readonly) Class       tableViewCellClass;
@property (nonatomic, readonly) Class       collectionViewCellClass;
@property (nonatomic, readonly) NSArray     *scopeModel;
@property (nonatomic, readonly) NSUInteger  startingIndex;

- (void)processPersons:(NSArray *)persons;
- (void)showError:(NSError *)error;

//never call this method directly!
- (void)loadPersons;

@end
