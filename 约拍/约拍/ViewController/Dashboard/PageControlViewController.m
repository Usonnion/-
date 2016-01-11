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

@interface PageControlViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray <ActionModel *> *actions;
@property (nonatomic, assign) BOOL firstView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PageControlViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mockData];
    self.firstView = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstView) {
        CGRect frame = self.view.frame;
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        
        for (ActionModel *action in self.actions) {
            NSInteger index = [self.actions indexOfObject:action];
            
            NSURL *imageUrl = [NSURL URLWithString:action.imageURL];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.frame = CGRectMake(frame.size.width * index, 0, frame.size.width, frame.size.height);
            [self.scrollView addSubview:imageView];
        }
        [self.scrollView setContentSize:CGSizeMake(frame.size.width * self.actions.count, frame.size.height)];
        [self.view addSubview:self.scrollView];
        
        ActionModel *firstModel = self.actions.lastObject;
        UIImage *firstImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:firstModel.imageURL]]];
        UIImageView *firstImageView = [[UIImageView alloc] initWithImage:firstImage];
        firstImageView.contentMode = UIViewContentModeScaleToFill;
        firstImageView.frame = CGRectMake(-frame.size.width, 0, frame.size.width, frame.size.height);
        [self.scrollView addSubview:firstImageView];
        
        ActionModel *latestModel = self.actions.firstObject;
        UIImage *latestImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:latestModel.imageURL]]];
        UIImageView *latestImageView = [[UIImageView alloc] initWithImage:latestImage];
        latestImageView.contentMode = UIViewContentModeScaleToFill;
        latestImageView.frame = CGRectMake(frame.size.width * self.actions.count, 0, frame.size.width, frame.size.height);
        [self.scrollView addSubview:latestImageView];
        
        [self.scrollView setContentInset:UIEdgeInsetsMake(0, self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width)];
        
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(srollToNextPage) userInfo:nil repeats:YES];
//    [self.timer setFireDate:[NSDate distantFuture]];
    
    self.firstView = NO;

}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
    self.timer = nil;
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.x < 0) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * (self.actions.count - 1), 0) animated:NO];
    } else if (point.x >= self.scrollView.frame.size.width * self.actions.count) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

@end
