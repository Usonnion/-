//
//  ProductsViewController.m
//  约拍
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductCell.h"
#import "ActionModel.h"
#import "ConstFile.h"

@interface ProductsViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *actions;

@end

@implementation ProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mockData];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.actions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *productCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    [productCell setContentData:self.actions[indexPath.row]];
    return productCell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 4)  / 2;
    return CGSizeMake(width, width + 80);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"PhotosViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)mockData
{
    ActionModel *action1 = [[ActionModel alloc] init];
    action1.imageURL = @"http://i4.tietuku.com/ed6c25f8d0c526f8.jpg";
    
    ActionModel *action2 = [[ActionModel alloc] init];
    action2.imageURL = @"http://i11.tietuku.com/59a5e776cdb0a07e.jpg";
    
    ActionModel *action3 = [[ActionModel alloc] init];
    action3.imageURL = @"http://i12.tietuku.com/6255d9b25b0e6fa9.jpg";
    
    self.actions = @[action1, action2, action3];
}

@end
