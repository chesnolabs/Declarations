//
//  UITableView+DCTableViewCategory.m
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "UITableView+DCTableViewCategory.h"
#import "NSBundle+DCBundleCategory.h"

@implementation UITableView (DCTableViewCategory)

- (UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    return cell;
}

- (UITableViewCell *)reusableCellWithClass:(Class)cellClass {
    UITableViewCell *cell = [self dequeueReusableCellWithClass:cellClass];
    
    if (!cell) {
        cell = [NSBundle objectWithClass:cellClass];
    }
    
    return cell;
}

@end
