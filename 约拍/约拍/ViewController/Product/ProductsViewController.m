//
//  ProductsViewController.m
//  约拍
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductCell.h"
#import "PhotosViewController.h"
#import "ProductModel.h"

@interface ProductsViewController () <BuyProductDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *noProductLabel;

@property (nonatomic, strong) NSArray *products;

@end

@implementation ProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setViewData];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *productCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    [productCell setContentData:self.products[indexPath.row]];
    productCell.delegate = self;
    return productCell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 4)  / 2;
    return CGSizeMake(width, width + 60);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel *product = self.products[indexPath.row];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    PhotosViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"PhotosViewController"];
    viewController.product = product;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - BuyProductDelegate

- (void)buyProduct:(id)action
{
    [NavigatorManager navigatorBy:action viewController:self];
}

- (void)setViewData
{
    if (self.action.navigatorType == NavigatorTypeByType) {
        self.products = [[DiskCacheManager sharedManager] getProductByProductType:self.action.productType];
        self.title = self.action.title;
    } else if (self.action.navigatorType == NavigatorTypeByStore) {
        self.products = [[DiskCacheManager sharedManager] getProductByStoreId:self.action.storeId];
        StoreModel *store = [[DiskCacheManager sharedManager] getStoreByStoreId:self.action.storeId];
        self.title = store.storeName;
    }
    
    if (self.products && self.products.count > 0) {
        self.noProductLabel.hidden = YES;
    } else {
        self.noProductLabel.hidden = NO;
    }
}

@end
