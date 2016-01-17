//
//  PhotoViewController.m
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    CGRect frame = [UIScreen mainScreen].bounds;
    NSURL *imageUrl = [NSURL URLWithString:self.photoURL];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView = imageView;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = imageView.frame.size;
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.delegate = self;
        
    [self setZoomParametersForSize:self.scrollView.bounds.size];
    [self recenterImage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [self setZoomParametersForSize:self.scrollView.bounds.size];
    [self recenterImage];
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.superViewController.isScale = scrollView.zoomScale != scrollView.minimumZoomScale;
    [self recenterImage];
}

#pragma mark - Private Methods

- (void)recenterImage
{
    CGSize scrollViewSize = self.scrollView.bounds.size;
    CGSize imageSize = self.imageView.frame.size;
    
    CGFloat horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0;
    CGFloat verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0;
    self.scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace);
}

- (void)setZoomParametersForSize:(CGSize)scrollSize
{
    CGSize imageSize = self.imageView.bounds.size;
    
    CGFloat widthScale = scrollSize.width / imageSize.width;
    CGFloat heightScale = scrollSize.height / imageSize.height;
    CGFloat minScale = MIN(widthScale, heightScale);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.zoomScale = minScale;
}

@end
