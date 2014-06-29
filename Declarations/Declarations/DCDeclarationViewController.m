//
//  DCDeclarationViewController.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeclarationViewController.h"
#import "DCCategoryCell.h"
#import "DCCategory.h"
#import "DCCategoryViewController.h"

@interface DCDeclarationViewController ()

@end

@implementation DCDeclarationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.declaration.title;
}

- (IBAction)cancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return self.declaration.categories.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCCategoryCell *cell = (DCCategoryCell *)[cv dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    DCCategory *category = (DCCategory *)self.declaration.categories[indexPath.row];
    cell.titleView.text = category.name;
    cell.imageView.image = category.icon;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"DeclarationCategorySegue" sender:(DCCategory *)self.declaration.categories[indexPath.row]];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DeclarationCategorySegue"])
    {
        ((DCCategoryViewController *)segue.destinationViewController).category = sender;
    }
}

@end
