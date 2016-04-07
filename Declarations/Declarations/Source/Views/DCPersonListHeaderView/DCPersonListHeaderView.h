//
//  DCPersonListHeaderView.h
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCPersonListHeaderView : UIView
@property (nonatomic, strong) IBOutlet UILabel      *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView  *maskImageView;

+ (instancetype)headerView;

- (void)fillWithString:(NSString *)sectionTitle;

@end
