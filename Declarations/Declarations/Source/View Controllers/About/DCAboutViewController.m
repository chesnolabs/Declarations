//
//  DCAboutViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 13.10.14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCAboutViewController.h"

@interface DCAboutViewController ()

@end

@implementation DCAboutViewController

#pragma mark -
#pragma mark Interface Handling

- (IBAction)feedBackAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:gudvadym@gmail.com"]];
}

- (IBAction)clickLogoAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://chesno.org"]];
}

@end
