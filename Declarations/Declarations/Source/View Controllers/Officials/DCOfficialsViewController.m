//
//  DCOfficialsViewController.m
//  Declarations
//
//  Created by tanlan on 18.09.14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCOfficialsViewController.h"
#import "DCOfficialsView.h"
#import "DCDataLoader.h"

#import "UIView+MILoadingViewCategory.h"
#import "DCPropertyMacros.h"

@interface DCOfficialsViewController ()
@property (nonatomic, readonly) DCOfficialsView    *rootView;

@end

@implementation DCOfficialsViewController

#pragma mark -
#pragma mark Accessors

DCViewControllerViewOfClassGetterSynthesize(DCOfficialsView, rootView);

- (void)loadPersons {
    [self.rootView showLoadingView];
    
    DCDataLoader *loader = [DCDataLoader new];
    [loader loadOfficialsWithCompletionHandler:^(NSArray *persons, NSError *error) {
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
