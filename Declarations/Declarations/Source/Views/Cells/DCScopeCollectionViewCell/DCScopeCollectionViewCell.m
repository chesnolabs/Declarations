//
//  DCScopeCollectionViewCell.m
//  Declarations
//
//  Created by Varvara Mironova on 3/24/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "DCScopeCollectionViewCell.h"
#import "DCArrayModel.h"

#import "DCColorMacros.h"

@interface DCScopeCollectionViewCell ()
@property (nonatomic, assign)   CGFloat     deselectedLabelFontSize;
@property (nonatomic, strong)   NSString    *deselectedFontFamily;

@end

@implementation DCScopeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UILabel *label = self.scopeLabel;
    
    self.deselectedLabelFontSize = label.font.pointSize;
    self.deselectedFontFamily = @"AvenirNext-DemiBold";
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    CGFloat fontSize = self.deselectedLabelFontSize;
    NSString *fontFamily = self.deselectedFontFamily;
    
    //change label's fontSize if it's selected
    if (selected) {
        fontSize += 2;
        fontFamily = @"AvenirNext-Bold";
    }
    
    self.tickImageView.hidden = !selected;
    UILabel *scopeLabel = self.scopeLabel;
    scopeLabel.textColor = selected ? kDCSelectedScopeBarColor : kDCDeselectedScopeBarColor;
    
    [scopeLabel setFont:[UIFont fontWithName:fontFamily size:fontSize]];
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(DCArrayModel *)model {
    self.scopeLabel.text = model.title;
}

@end
