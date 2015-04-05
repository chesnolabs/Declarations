//
//  DCFirstViewController.h
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCDeputyViewController : UITableViewController

- (void)loadPersons;
- (void)processPersons:(NSArray *)persons;
- (void)showSpinIndicator;
- (void)showError:(NSError *)error;

- (void)updateWithSelectedParliament:(NSArray *)selectedParliaments;

@end
