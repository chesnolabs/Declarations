//
//  DCDeclarationsViewController.h
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCDeputy.h"

@interface DCDeclarationsViewController : UIViewController

@property (strong) DCDeputy *deputy;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end
