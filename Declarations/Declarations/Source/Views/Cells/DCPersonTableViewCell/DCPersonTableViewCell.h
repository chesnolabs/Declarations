//
//  DCPersonTableViewCell.h
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCPerson;

@interface DCPersonTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (void)fillWithModel:(DCPerson *)model;

@end
