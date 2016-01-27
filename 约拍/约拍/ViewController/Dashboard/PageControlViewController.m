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

@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray <ActionModel *> *actions;
@property (nonatomic, assign) BOOL firstView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGRect frame;

@end

@implementation PageControlViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mockData];
    self.firstView = YES;
//    self.view.frame = self.frame;
}

+ (PageControlViewController *)pageControlViewControllerWithFrame:(CGRect)frame scrollCircle:(BOOL)scrollCircle autoScroll:(BOOL)autoScroll
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Dashboard" bundle:nil];
    PageControlViewController *pageViewController = [storyBoard instantiateViewControllerWithIdentifier:@"PageControlViewController"];
    pageViewController.frame = frame;
    pageViewController.view.frame = frame;
    pageViewController.scrollCircle = scrollCircle;
    pageViewController.autoScroll = autoScroll;
    return pageViewController;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstView) {
        self.view.frame = self.frame;
        CGRect frame = self.view.frame;
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        
        for (ActionModel *action in self.actions) {
            NSInteger index = [self.actions indexOfObject:action];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:action.imageURL]];
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.frame = CGRectMake(frame.size.width * index, 0, frame.size.width, frame.size.height);
            [self.scrollView addSubview:imageView];
        }
        [self.scrollView setContentSize:CGSizeMake(frame.size.width * self.actions.count, frame.size.height)];
        [self.view addSubview:self.scrollView];
        
        if (self.actions.count > 1 && self.scrollCircle) {
            ActionModel *firstModel = self.actions.lastObject;
            UIImageView *firstImageView = [[UIImageView alloc] init];
            [firstImageView sd_setImageWithURL:[NSURL URLWithString:firstModel.imageURL]];
            firstImageView.contentMode = UIViewContentModeScaleToFill;
            firstImageView.frame = CGRectMake(-frame.size.width, 0, frame.size.width, frame.size.height);
            [self.scrollView addSubview:firstImageView];
            
            ActionModel *latestModel = self.actions.firstObject;
            UIImageView *latestImageView = [[UIImageView alloc] init];
            [latestImageView sd_setImageWithURL:[NSURL URLWithString:latestModel.imageURL]];
            latestImageView.contentMode = UIViewContentModeScaleToFill;
            latestImageView.frame = CGRectMake(frame.size.width * self.actions.count, 0, frame.size.width, frame.size.height);
            [self.scrollView addSubview:latestImageView];
            
            [self.scrollView setContentInset:UIEdgeInsetsMake(0, self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width)];
        }
        
    }
    
    if (self.actions.count > 1 && self.autoScroll) {
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
    if (self.scrollCircle) {
        CGPoint point = scrollView.contentOffset;
        if (point.x < 0) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * (self.actions.count - 1), 0) animated:NO];
        } else if (point.x >= self.scrollView.frame.size.width * self.actions.count) {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }
}

@end
