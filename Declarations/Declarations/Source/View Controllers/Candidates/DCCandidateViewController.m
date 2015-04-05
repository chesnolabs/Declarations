//
//  DCFirstViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/19/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCCandidateViewController.h"
#import "DCDataLoader.h"

@implementation DCCandidateViewController

- (void)loadPersons
{
    [self showSpinIndicator];
    
    DCDataLoader *loader = [[DCDataLoader alloc] init];
    [loader loadCandidatesWithCompletionHandler:^(NSArray *persons, NSError *error) {
        if (persons != nil)
        {
            [self processPersons:persons];
        }
        else
        {
            [self showError:error];
        }
    }];
}

@end
