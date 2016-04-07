//
//  DCMailToView.h
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCMailToView : UIView
@property (nonatomic, strong) IBOutlet UIImageView  *mailToImageView;
@property (nonatomic, strong) IBOutlet UILabel      *mailToLabel;

+ (instancetype)mailToViewInView:(UIView *)view;

@end
