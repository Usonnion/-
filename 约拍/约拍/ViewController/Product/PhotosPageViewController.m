//
//  PhotosPageViewController.m
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PhotosPageViewController.h"
#import "PhotoViewController.h"

@interface PhotosPageViewController ()

@property (nonatomic, assign) NSInteger pageCount;

@end

@implementation PhotosPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self mockData];
    self.dataSource = self;
    [self setViewControllers:@[[self tutorialStepForPage:self.page]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageCount = self.photos.count;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
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

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    PhotoViewController *photoViewController = (PhotoViewController *)viewController;
    self.page = photoViewController.page;
    if (photoViewController.page > 0) {
        return [self tutorialStepForPage:photoViewController.page - 1];
    }
    
    return nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    PhotoViewController *photoViewController = (PhotoViewController *)viewController;
    self.page = photoViewController.page;
    if (photoViewController.page < self.pageCount - 1) {
        return [self tutorialStepForPage:photoViewController.page + 1];
    }
    
    return nil;
}

#pragma mark - Private Methods

- (PhotoViewController *)tutorialStepForPage:(NSInteger)page
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    PhotoViewController *photoViewController = [storyBoard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    photoViewController.page = page;
    photoViewController.photoURL = self.photos[page];
    photoViewController.superViewController = self;
    return photoViewController;
}

- (void)tapPhoto:(UIGestureRecognizer *)gestureRecognizer
{
    if (!self.isScale) {
        self.photosViewController.selectedPage = self.page;
        [self dismissViewControllerAnimated:NO completion:^{
            [self.photosViewController backToPhotosViewController];
        }];
    }
}

- (void)mockData
{
    self.photos = @[@"http://i4.tietuku.com/ed6c25f8d0c526f8.jpg", @"http://i11.tietuku.com/59a5e776cdb0a07e.jpg", @"http://i12.tietuku.com/6255d9b25b0e6fa9.jpg"];
}


@end
