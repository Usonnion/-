//
//  PhotosViewController.m
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"
#import "UIView+Snapshot.h"
#import "ConstFile.h"
#import "PhotosPageViewController.h"
#import "UIImage+WebCache.h"

@interface PhotosViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, weak) UIView *maskView;
@property (nonatomic, weak) UIImageView *currentPhoto;

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
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithUrl:self.photos[indexPath.row]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = cell.bounds;
    imageView.center = cell.center;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, screenBounds.size.width, screenBounds.size.height + 20)];
    view.backgroundColor = [UIColor blackColor];
    [view addSubview:imageView];
    self.maskView = view;
    self.currentPhoto = imageView;
    
    [self.view addSubview:view];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"PhotosPageViewController"];
    PhotosPageViewController *photosPageViewController = (PhotosPageViewController *)viewController;
    photosPageViewController.photosViewController = self;
    photosPageViewController.page = indexPath.row;
    photosPageViewController.photos = self.photos;
    
    [UIView animateWithDuration:0.4 animations:^{
        imageView.frame = view.frame;
        imageView.center = CGPointMake(view.center.x, view.center.y + 30);
    } completion:^(BOOL finished) {
        [self presentViewController:viewController animated:NO completion:nil];
    }];
}

- (void)backToPhotosViewController
{
    [self.currentPhoto setImage:[UIImage imageWithUrl:self.photos[self.selectedPage]]];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedPage inSection:0]];
    [UIView animateWithDuration:0.4 animations:^{
        self.currentPhoto.frame = cell.frame;
        self.currentPhoto.center = cell.center;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
    }];
}

- (void)mockData
{
    self.photos = @[@"http://i4.tietuku.com/ed6c25f8d0c526f8.jpg", @"http://i11.tietuku.com/59a5e776cdb0a07e.jpg", @"http://i12.tietuku.com/6255d9b25b0e6fa9.jpg"];
}


@end
