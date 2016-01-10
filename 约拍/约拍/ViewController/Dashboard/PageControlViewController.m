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

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray <ActionModel *> *actions;
@property (nonatomic, assign) BOOL firstView;

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
        self.scrollView.frame = frame;
        self.scrollView.contentSize = CGSizeMake(frame.size.width * self.actions.count, frame.size.height);
        
        for (ActionModel *action in self.actions) {
            NSInteger index = [self.actions indexOfObject:action];
            
            //        NSURL *imageUrl = [NSURL URLWithString:action.imageURL];
            //        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            //        UIImage *image = [UIImage imageWithData:imageData];
            //        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            //        imageView.contentMode = UIViewContentModeScaleToFill;
            //        imageView.frame = CGRectMake(frame.size.width * index, 0, frame.size.width, 200);
            //        [self.scrollView addSubview:imageView];
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width * index, 0, frame.size.width, frame.size.height)];
            button.tag = index;
            [button setBackgroundColor:[UIColor blackColor]];
            [button sd_setImageWithURL:[NSURL URLWithString:action.imageURL] forState:UIControlStateNormal];
            [self.scrollView addSubview:button];
        }
    }
    
    self.firstView = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//#pragma mark - UIScrollViewDelegate
//
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    CGFloat index = targetContentOffset->x / self.view.frame.size.width;
//    NSInteger targetIndex = roundf(index);
//    if (targetIndex >= self.actions.count) {
//        targetIndex = 0;
//    }
//    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width *targetIndex, targetContentOffset->x) animated:YES];
//}

#pragma mark - Private methods

- (void)mockData
{
    ActionModel *action1 = [[ActionModel alloc] init];
    action1.imageURL = @"http://i4.tietuku.com/ed6c25f8d0c526f8.jpg";
    
    ActionModel *action2 = [[ActionModel alloc] init];
    action2.imageURL = @"http://i4.tietuku.com/ed6c25f8d0c526f8.jpg";
    
    ActionModel *action3 = [[ActionModel alloc] init];
    action3.imageURL = @"http://i4.tietuku.com/24abe9720df78b35.jpg";
    
    self.actions = @[action1, action2, action3];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
