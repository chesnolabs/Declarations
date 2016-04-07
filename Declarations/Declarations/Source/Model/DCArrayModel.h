//
//  DCArrayModel.h
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCArrayModel : NSObject
@property (nonatomic, readonly) NSArray     *models;
@property (nonatomic, strong)   NSString    *title;

+ (instancetype)model;

- (id)firstObject;
- (id)lastObject;

- (void)addModel:(id)model;
- (void)insertModel:(id)model atIndex:(NSUInteger)index;
- (void)removeModel:(id)model;
- (void)removeModelWithIndex:(NSUInteger)index;

- (void)addModels:(NSArray *)models;
- (void)removeModels:(NSArray *)models;
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;
- (NSUInteger)count;

- (BOOL)containsObject:(id)object;

@end
