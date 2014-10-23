//
//  DCOfficialsViewController.m
//  Declarations
//
//  Created by tanlan on 18.09.14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCOfficialsViewController.h"
#import "DCDataLoader.h"

@implementation DCOfficialsViewController

- (void)loadPersons
{
    DCDataLoader *loader = [[DCDataLoader alloc] init];
    [loader loadOfficialsWithCompletionHandler:^(NSArray *persons, NSError *error) {
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
