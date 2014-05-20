//
//  DCDeclaration.h
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCDeclaration : NSObject

- (id)initWithJSONObject:(NSDictionary *)jsonObject;

@property (strong, nonatomic) NSString *title;
@property (assign) NSUInteger year;
@property (strong) NSURL *linkToSource;
@property (strong) NSDictionary *data;

@end
