//
//  DCArrayModel.m
//  Declarations
//
//  Created by Varvara Mironova on 3/23/16.
//  Copyright © 2016 Chesno. All rights reserved.
//

#import "DCArrayModel.h"

@interface DCArrayModel ()
@property (nonatomic, strong)   NSMutableArray     *mutableModels;

@end

@implementation DCArrayModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)model {
    DCArrayModel *model = [self new];
    model.mutableModels = [NSMutableArray array];
    
    return model;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)models {
    @synchronized(self.mutableModels) {
        return [self.mutableModels copy];
    }
}

#pragma mark -
#pragma mark Private


#pragma mark -
#pragma mark Public

- (id)firstObject {
    @synchronized(self.mutableModels) {
        return [self.mutableModels firstObject];
    }
}

- (id)lastObject {
    @synchronized(self.mutableModels) {
        return [self.mutableModels lastObject];
    }
}

- (void)addModel:(id)model {
    @synchronized(self.mutableModels) {
        if (model) {
            [self.mutableModels addObject:model];
        } else {
            NSLog(@"Cannot add nil to array:%@ ", self.mutableModels);
        }
    }
}

- (void)insertModel:(id)model atIndex:(NSUInteger)index {
    @synchronized(self.mutableModels) {
        if (![self.mutableModels containsObject:model]) {
            [self.mutableModels insertObject:model atIndex:index];
        }
    }
}

- (void)removeModel:(id)model {
    @synchronized(self.mutableModels) {
        if ([self.mutableModels containsObject:model]) {
            [self.mutableModels removeObject:model];
        }
    }
}

- (void)removeModelWithIndex:(NSUInteger)index {
    @synchronized(self.mutableModels) {
        id model = [self objectAtIndex:index];
        
        [self.mutableModels removeObject:model];
    }
}

- (id)objectAtIndex:(NSUInteger)index {
    @synchronized(self.mutableModels) {
        return self.mutableModels[index];
    }
}

- (NSUInteger)indexOfObject:(id)object {
    @synchronized(self.mutableModels) {
        return [self.mutableModels indexOfObject:object];
    }
}

- (NSUInteger)count {
    @synchronized(self.mutableModels) {
        return [self.mutableModels count];
    }
}

- (BOOL)containsObject:(id)object {
    @synchronized(self.mutableModels) {
        return [self.mutableModels containsObject:object];
    }
}

- (void)addModels:(NSArray *)models {
    @synchronized(self.mutableModels) {
        if (models) {
            [self.mutableModels addObjectsFromArray:models];
        }
    }
}

- (void)removeModels:(NSArray *)models {
    @synchronized(self.mutableModels) {
        if (models) {
            [self.mutableModels removeObjectsInArray:models];
        }
    }
}

@end
