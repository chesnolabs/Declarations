//
//  DCDeclarationViewController.h
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCDeclaration.h"

@interface DCDeclarationViewController : UIViewController

@property (strong) DCDeclaration *declaration;
@property (strong, nonatomic) IBOutlet UITextField *dumpView;

@end
