//
//  DCParliament.m
//  Declarations
//
//  Created by Vera Tkachenko on 1/7/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import "DCParliament.h"

#import "LGMRomanNumber.h"

@interface DCParliament ()

@end

@implementation DCParliament

#pragma mark -
#pragma mark Accessors

- (NSString *)title {
    NSString *title = self.convocationNumber > 2000 ? [NSString stringWithFormat:@"Скликання %ld р.", (unsigned long)self.convocationNumber] : [NSString stringWithFormat:@"%@ скликання", [LGMRomanNumber romanFromArabic:self.convocationNumber]];
    
    return title;
}

@end
