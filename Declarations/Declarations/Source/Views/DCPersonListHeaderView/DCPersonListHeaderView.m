//
//  DCPersonListHeaderView.m
//  Declarations
//
//  Created by Varvara Mironova on 3/26/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "DCPersonListHeaderView.h"

#import "NSBundle+DCBundleCategory.h"

@implementation DCPersonListHeaderView

#pragma mark -
#pragma mark Class Functions

+ (instancetype)headerView {
    DCPersonListHeaderView *headerView = [NSBundle objectWithClass:[self class]];
    
    return headerView;
}

#pragma mark -
#pragma mark Public

- (void)fillWithString:(NSString *)sectionTitle {
    self.titleLabel.text = sectionTitle;
}

@end
