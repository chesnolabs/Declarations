//
//  DCDeclarationViewController.h
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCDeclaration.h"

@interface DCDeclarationViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout >

@property (strong) DCDeclaration *declaration;

@end
