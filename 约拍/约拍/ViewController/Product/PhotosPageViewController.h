//
//  PhotosPageViewController.h
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PhotosViewController.h"

@protocol PhotosPageViewControllerDelegate <NSObject>

- (void)setSelectedPage:(NSInteger)selectedPage;
- (void)backToPhotosViewController;

@end

@interface PhotosPageViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) BOOL isScale;

@property (nonatomic, weak) id<PhotosPageViewControllerDelegate> delegate;

@end
