//
//  PaymentViewController.m
//  约拍
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PaymentViewController.h"
#import "PageControlViewController.h"
#import "CustomerNavigatorItem.h"
#import "ProductDescription.h"
#import "StoreModel.h"
#import "StoreDescription.h"
#import "SDImageCache.h"
#import "PhotosPageViewController.h"
#import "UIImageView+WebCache.h"

@interface PaymentViewController() <CustomerNavigatorItemDelegate, UIScrollViewDelegate, PageControlViewControllerDelegate, PhotosPageViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) UIView *pageView;
@property (nonatomic, weak) UIView *maskView;
@property (nonatomic, weak) UIImageView *maskImageView;
@property (nonatomic, weak) PageControlViewController *pageControlViewController;
@property (nonatomic, weak) CustomerNavigatorItem *customerNavigatorItem;

@property (nonatomic, strong) ProductModel *product;

@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.product = [[DiskCacheManager sharedManager] getProductByProductId:self.action.productId];
    StoreModel *store = [[DiskCacheManager sharedManager] getStoreByStoreId:self.product.storeId];
    
    PageControlViewController *pageViewController = [PageControlViewController pageControlViewControllerWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width) images:self.product.images scrollCircle:NO autoScroll:NO];
    pageViewController.delegate = self;
    self.pageControlViewController = pageViewController;
    [self.scrollView addSubview: pageViewController.view];
    self.pageView = pageViewController.view;
    [self addChildViewController:pageViewController];
    
    CustomerNavigatorItem *customerNavigatorItem = [CustomerNavigatorItem customerNavigatorItemWithFrame:CGRectMake(0, 0, screenBounds.size.width, 64)];
    customerNavigatorItem.delegate = self;
    self.customerNavigatorItem = customerNavigatorItem;
    [self.view addSubview:customerNavigatorItem];
    
    ProductDescription *productDescription = [ProductDescription productDescriptionWithProduct:self.product];
    productDescription.frame = CGRectMake(0, screenBounds.size.width, screenBounds.size.width, productDescriptionHeight);
    [self.scrollView addSubview:productDescription];
    
    StoreDescription *storeDescription = [StoreDescription StoreDescriptionWithStore:store];
    storeDescription.frame = CGRectMake(0, screenBounds.size.width + productDescriptionHeight, screenBounds.size.width, storeDescriptionHeight);
    [self.scrollView addSubview:storeDescription];
    
    [self.scrollView setContentSize:CGSizeMake(screenBounds.size.width, screenBounds.size.width + screenBounds.size.height)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - CustomerNavigatorItemDelegate

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yPozition = scrollView.contentOffset.y;
    if (0.0 <= yPozition &&  yPozition < screenBounds.size.width) {
        [self.pageView setFrame:CGRectMake(0, yPozition / 2, screenBounds.size.width, screenBounds.size.width)];
        [self.customerNavigatorItem setOffset:yPozition * 2 / screenBounds.size.width];
    } else if (0.0 > yPozition) {
        [self.pageView setFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width)];
        [self.customerNavigatorItem setOffset:0];
    }
}

#pragma mark - PageControlViewControllerDelegate

- (void)pagePressed:(NSInteger)page
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:self.product.images[page]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, screenBounds.size.width, screenBounds.size.height + 20)];
    view.backgroundColor = [UIColor blackColor];
    [view addSubview:imageView];
    [self.view addSubview:view];
    
    self.maskView = view;
    self.maskImageView = imageView;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"PhotosPageViewController"];
    PhotosPageViewController *photosPageViewController = (PhotosPageViewController *)viewController;
    photosPageViewController.pagedelegate = self;
    photosPageViewController.page = page;
    photosPageViewController.photos = self.product.images;
    [self setSelectedPage:page];
    
    [UIView animateWithDuration:0.4 animations:^{
        imageView.frame = view.frame;
        imageView.center = CGPointMake(view.center.x, view.center.y + 30);
    } completion:^(BOOL finished) {
        [self presentViewController:viewController animated:NO completion:nil];
    }];
}

- (void)setSelectedPage:(NSInteger)selectedPage
{
    [self.maskImageView sd_setImageWithURL:[NSURL URLWithString:self.product.images[selectedPage]]];
    [self.pageControlViewController setCurrentPage:selectedPage];
}

- (void)backToPhotosViewController
{
    [UIView animateWithDuration:0.4 animations:^{
        self.maskImageView.frame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width);
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
    }];
}

@end
