//
//  PhotoViewController.m
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) BOOL firstView;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mockData];
    self.firstView = YES;
    self.scrollView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstView) {
        CGRect frame = self.view.frame;
        self.pageControl.numberOfPages = self.photos.count;
        
        for (NSString *photoURL in self.photos) {
            NSInteger index = [self.photos indexOfObject:photoURL];
            
            NSURL *imageUrl = [NSURL URLWithString:photoURL];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.frame = CGRectMake(frame.size.width * index, 10, frame.size.width, frame.size.height - 44);
            [self.scrollView addSubview:imageView];
            
        }
        
        [self.scrollView setContentSize:CGSizeMake(frame.size.width * self.photos.count, frame.size.height - 20)];
    }
    
    self.firstView = NO;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.pageControl setCurrentPage:scrollView.contentOffset.x / self.view.frame.size.width];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)mockData
{
    self.photos = @[@"http://i4.tietuku.com/ed6c25f8d0c526f8.jpg", @"http://i11.tietuku.com/59a5e776cdb0a07e.jpg", @"http://i12.tietuku.com/6255d9b25b0e6fa9.jpg"];
}


@end
