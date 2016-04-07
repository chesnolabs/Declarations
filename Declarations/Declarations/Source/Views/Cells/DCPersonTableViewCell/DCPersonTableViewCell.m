//
//  DCPersonTableViewCell.m
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "DCPersonTableViewCell.h"
#import "DCPerson.h"

@implementation DCPersonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(DCPerson *)model {
    self.titleLabel.text = model.fullName;
}

@end
