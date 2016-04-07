//
//  DCFirstViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeputyViewController.h"
#import "DCDeputyView.h"
#import "DCParliamentFactory.h"
#import "DCDataLoader.h"

#import "UIView+MILoadingViewCategory.h"
#import "DCPropertyMacros.h"

@interface DCDeputyViewController ()
@property (nonatomic, readonly) DCDeputyView    *rootView;

@end

@implementation DCDeputyViewController

#pragma mark -
#pragma mark Accessors

DCViewControllerViewOfClassGetterSynthesize(DCDeputyView, rootView);

- (NSArray *)scopeModel {
    return [DCParliamentFactory sharedInstance].parliaments;
}

- (NSUInteger)startingIndex {
    return [self.scopeModel count] / 2;
}

#pragma mark -
#pragma mark Private

- (void)loadPersons {
    [self.rootView showLoadingView];
    
    DCDataLoader *loader = [DCDataLoader new];
    [loader loadDeputiesWithCompletionHandler:^(NSArray *persons, NSError *error) {
        if (persons != nil) {
            [self processPersons:persons];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showError:error];
            });
        }
    }];
}

@end
