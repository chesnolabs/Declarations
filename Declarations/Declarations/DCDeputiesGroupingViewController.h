//
//  DCDeputiesGroupingViewController.h
//  Declarations
//
//  Created by Vera Tkachenko on 1/11/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCDeputyViewController.h"

@interface DCDeputiesGroupingViewController : UITableViewController

@property NSMutableArray *selectedParliaments;
@property (weak) DCDeputyViewController *deputyViewController;

@end
