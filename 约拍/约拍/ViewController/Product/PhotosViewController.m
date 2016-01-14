//
//  PhotosViewController.m
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"

@interface PhotosViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *photos;

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mockData];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCell"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    [photoCell setImage:self.photos[indexPath.row]];
    return photoCell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 4)  / 2;
    return CGSizeMake(width, width);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)mockData
{
    self.photos = @[@"http://i4.tietuku.com/ed6c25f8d0c526f8.jpg", @"http://i11.tietuku.com/59a5e776cdb0a07e.jpg", @"http://i12.tietuku.com/6255d9b25b0e6fa9.jpg"];
}


@end
