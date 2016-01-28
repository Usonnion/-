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

@interface PaymentViewController() <CustomerNavigatorItemDelegate, UIScrollViewDelegate, PageControlViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) UIView *pageView;
@property (nonatomic, weak) CustomerNavigatorItem *customerNavigatorItem;

@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ProductModel *product = [[DiskCacheManager sharedManager] getProductByProductId:self.action.productId];
    
    PageControlViewController *pageViewController = [PageControlViewController pageControlViewControllerWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width) images:product.images scrollCircle:NO autoScroll:NO];
    [self.scrollView addSubview: pageViewController.view];
    self.pageView = pageViewController.view;
    [self addChildViewController:pageViewController];
    CustomerNavigatorItem *customerNavigatorItem = [CustomerNavigatorItem customerNavigatorItemWithFrame:CGRectMake(0, 0, screenBounds.size.width, 64)];
    customerNavigatorItem.delegate = self;
    self.customerNavigatorItem = customerNavigatorItem;
    [self.view addSubview:customerNavigatorItem];
    
    ProductDescription *productDescription = [ProductDescription productDescriptionWithProduct:product];
    productDescription.frame = CGRectMake(0, screenBounds.size.width, screenBounds.size.width, screenBounds.size.height);
    [self.scrollView addSubview:productDescription];
    
    [self.scrollView setContentSize:CGSizeMake(screenBounds.size.width, screenBounds.size.width + screenBounds.size.height)];
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

#pragma mark - CustomerNavigatorItemDelegate

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yPozition = scrollView.contentOffset.y;
    if (0.0 < yPozition &&  yPozition < screenBounds.size.width) {
        [self.pageView setFrame:CGRectMake(0, yPozition / 2, screenBounds.size.width, screenBounds.size.width)];
        [self.customerNavigatorItem setOffset:yPozition * 2 / screenBounds.size.width ];
    }
}

#pragma mark - PageControlViewControllerDelegate

- (void)pagePressed:(NSInteger)page
{
    
}

@end
