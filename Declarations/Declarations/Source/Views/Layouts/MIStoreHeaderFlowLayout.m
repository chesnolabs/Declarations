//
//  MIStoreHeaderFlowLayout.m
//  miinu
//
//  Created by Varvara Mironova on 7/21/15.
//  Copyright (c) 2015 Miinu. All rights reserved.
//

#import "MIStoreHeaderFlowLayout.h"

@implementation MIStoreHeaderFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0.0;
    self.minimumInteritemSpacing = 0.0;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)offset
                                 withScrollingVelocity:(CGPoint)velocity
{
    CGRect bounds = self.collectionView.bounds;
    CGFloat halfWidth = bounds.size.width * 0.5f;
    CGFloat proposedContentOffsetCenterX = offset.x + halfWidth;
    
    NSArray *attributesArray = [self layoutAttributesForElementsInRect:bounds];
    
    UICollectionViewLayoutAttributes *candidateAttributes = nil;
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        
        if (attributes.representedElementCategory != UICollectionElementCategoryCell) {
            continue;
        }
        
        if (!candidateAttributes) {
            candidateAttributes = attributes;
            
            continue;
        }
        
        if (fabs(attributes.center.x - proposedContentOffsetCenterX) <
            fabs(candidateAttributes.center.x - proposedContentOffsetCenterX))
        {
            candidateAttributes = attributes;
        }
    }
    
    return CGPointMake(candidateAttributes.center.x - halfWidth, offset.y);
}

@end
