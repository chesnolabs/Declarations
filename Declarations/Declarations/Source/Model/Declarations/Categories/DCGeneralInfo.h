//
//  DCGeneralInfo.h
//  Declarations
//
//  Created by tanlan on 5/26/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCGeneralInfo : NSObject

- (id)initWithFamilyMembers:(NSArray *)members;

@property (strong, readonly) NSArray *familyMembers;

@end
