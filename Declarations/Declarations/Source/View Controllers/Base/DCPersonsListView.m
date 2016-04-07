//
//  DCPersonsListView.m
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "DCPersonsListView.h"

@implementation DCPersonsListView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.scopeBarCollectionView.allowsMultipleSelection = YES;
}

@end
