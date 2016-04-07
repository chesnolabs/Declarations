//
//  DCMailToButton.m
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "DCMailToButton.h"
#import "DCMailToView.h"

@interface DCMailToButton ()
@property (nonatomic, strong)   DCMailToView    *mailToView;

@end

@implementation DCMailToButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mailToView = [DCMailToView mailToViewInView:self];
}

@end
