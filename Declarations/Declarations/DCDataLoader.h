//
//  DCCommutator.h
//  Declarations
//
//  Created by tanlan on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  DCPerson;
@protocol DCDataLoaderDelegate;

@interface DCDataLoader : NSObject

- (id)initWithDelegate:(id<DCDataLoaderDelegate>)delegate;

@property (weak, readonly) id<DCDataLoaderDelegate> delegate;

- (void)loadPersonsWithCompletionHandler:(void (^)(NSArray *persons)) completionHandler;
- (void)loadDataForPerson:(DCPerson *)person completionHandler:(void (^)(BOOL success))block;

@end

@protocol DCDataLoaderDelegate <NSObject>

- (void)dataLoader:(DCDataLoader *)dataloader didFinishLoadingPerson:(DCPerson *)person;
- (void)dataLoader:(DCDataLoader *)dataloader didFailedLoadingPerson:(DCPerson *)person;

@end
