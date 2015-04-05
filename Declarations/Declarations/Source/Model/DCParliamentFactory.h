//
//  DCParliamentFactory.h
//  Declarations
//
//  Created by Vera Tkachenko on 1/7/15.
//  Copyright (c) 2015 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCParliament.h"

@interface DCParliamentFactory : NSObject

+ (instancetype)sharedInstance;
- (DCParliament *)parliamentWithConvocation:(NSUInteger)convocationNumber;

@property (readonly) NSArray *parliaments;

@end
