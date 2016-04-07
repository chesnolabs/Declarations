//
//  CGRect+DCExtension.m
//  Declarations
//
//  Created by Varvara Mironova on 4/5/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "CGRect+DCExtension.h"

CGRect CGRectFromCenter(CGPoint center, CGSize rectSize) {
    CGFloat originX = center.x - rectSize.width / 2.0;
    CGFloat originY = center.y - rectSize.height / 2.0;
    
    return CGRectMake(originX, originY, rectSize.width, rectSize.height);
}

CGPoint CGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetWidth(rect) / 2.0, CGRectGetHeight(rect) / 2.0);
}