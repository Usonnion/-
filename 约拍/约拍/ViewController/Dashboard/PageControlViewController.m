//
//  PageControlViewController.m
//  约拍
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PageControlViewController.h"
#import "ActionModel.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@interface PageControlViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) BOOL firstView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGRect frame;

@end

@implementation PageControlViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.firstView = YES;
    self.pageControl.numberOfPages = self.images.count;
}

+ (PageControlViewController *)pageControlViewControllerWithFrame:(CGRect)frame images:(NSArray *)images scrollCircle:(BOOL)scrollCircle autoScroll:(BOOL)autoScroll
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Dashboard" bundle:nil];
    PageControlViewController *pageViewController = [storyBoard instantiateViewControllerWithIdentifier:@"PageControlViewController"];
    pageViewController.frame = frame;
    pageViewController.view.frame = frame;
    pageViewController.scrollCircle = scrollCircle;
    pageViewController.autoScroll = autoScroll;
    pageViewController.images = images;
    return pageViewController;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstView) {
        self.view.frame = self.frame;
        CGRect frame = self.view.frame;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView = scrollView;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        
        for (NSString *imageUrl in self.images) {
            NSInteger index = [self.images indexOfObject:imageUrl];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.frame = CGRectMake(frame.size.width * index, 0, frame.size.width, frame.size.height);
            [self.scrollView addSubview:imageView];
        }
        [self.scrollView setContentSize:CGSizeMake(frame.size.width * self.images.count, frame.size.height)];
        [self.view addSubview:self.scrollView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pagePressed)];
        [self.scrollView addGestureRecognizer:tapGesture];
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.images.count;
        CGSize size = [pageControl sizeForNumberOfPages:self.images.count];
        pageControl.frame = CGRectMake((frame.size.width - size.width) / 2, frame.size.height - size.height - 6, size.width, size.height);
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self.view addSubview:pageControl];
        self.pageControl = pageControl;
        
        if (self.images.count > 1 && self.scrollCircle) {
            UIImageView *firstImageView = [[UIImageView alloc] init];
            [firstImageView sd_setImageWithURL:[NSURL URLWithString:self.images.lastObject]];
            firstImageView.contentMode = UIViewContentModeScaleToFill;
            firstImageView.frame = CGRectMake(-frame.size.width, 0, frame.size.width, frame.size.height);
            [self.scrollView addSubview:firstImageView];
            
            UIImageView *latestImageView = [[UIImageView alloc] init];
            [latestImageView sd_setImageWithURL:[NSURL URLWithString:self.images.firstObject]];
            latestImageView.contentMode = UIViewContentModeScaleToFill;
            latestImageView.frame = CGRectMake(frame.size.width * self.images.count, 0, frame.size.width, frame.size.height);
            [self.scrollView addSubview:latestImageView];
            
            [self.scrollView setContentInset:UIEdgeInsetsMake(0, self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width)];
        }
        
    }
    
    if (self.images.count > 1 && self.autoScroll) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(srollToNextPage) userInfo:nil repeats:YES];
    }
    
    self.firstView = NO;

}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)srollToNextPage
{
    CGPoint point = self.scrollView.contentOffset;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(point.x + self.view.frame.size.width, point.y);
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scrollView];
    }];
}

- (void)pagePressed
{
    if ([self.delegate respondsToSelector:@selector(pagePressed:)]) {
        [self.delegate pagePressed:self.pageControl.currentPage];
    }
}

- (void)setCurrentPage:(NSInteger)page
{
    [self.scrollView setContentOffset:CGPointMake(page * self.frame.size.width, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (self.scrollCircle) {
        if (point.x < 0) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * (self.images.count - 1), 0) animated:NO];
            self.pageControl.currentPage = self.images.count - 1;
        } else if (point.x >= self.scrollView.frame.size.width * self.images.count) {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            self.pageControl.currentPage = 0;
        } else {
            self.pageControl.currentPage = point.x / self.scrollView.frame.size.width;
        }
    } else {
        self.pageControl.currentPage = point.x / self.scrollView.frame.size.width;
    }
}

@end
