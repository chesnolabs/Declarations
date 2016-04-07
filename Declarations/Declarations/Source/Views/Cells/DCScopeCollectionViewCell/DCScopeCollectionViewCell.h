//
//  DCScopeCollectionViewCell.h
//  Declarations
//
//  Created by Varvara Mironova on 3/24/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCArrayModel;

@interface DCScopeCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel      *scopeLabel;
@property (strong, nonatomic) IBOutlet UIImageView  *tickImageView;

- (void)fillWithModel:(DCArrayModel *)model;

@end
