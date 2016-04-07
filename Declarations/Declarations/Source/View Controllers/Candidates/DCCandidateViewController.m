//
//  DCFirstViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCCandidateViewController.h"
#import "DCCandidatesView.h"
#import "DCDataLoader.h"
#import "DCParliamentFactory.h"

#import "UIView+MILoadingViewCategory.h"
#import "DCPropertyMacros.h"

@interface DCCandidateViewController ()
@property (nonatomic, readonly) DCCandidatesView    *rootView;

@end

@implementation DCCandidateViewController

#pragma mark -
#pragma mark Accessors

DCViewControllerViewOfClassGetterSynthesize(DCCandidatesView, rootView);

- (NSArray *)scopeModel {
    return [DCParliamentFactory sharedInstance].kindsOfCandidates;
}

#pragma mark -
#pragma mark Private
- (void)loadPersons {
    [self.rootView showLoadingView];
    
    DCDataLoader *loader = [DCDataLoader new];
    [loader loadCandidatesWithCompletionHandler:^(NSArray *persons, NSError *error) {
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
