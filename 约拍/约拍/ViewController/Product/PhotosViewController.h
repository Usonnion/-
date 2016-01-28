//
//  PhotosViewController.h
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "PhotosPageViewController.h"

@interface PhotosViewController : UIViewController <PhotosPageViewControllerDelegate>

@property (nonatomic, strong) ProductModel *product;

- (void)backToPhotosViewController;

@end
