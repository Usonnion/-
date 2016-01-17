//
//  PhotoViewController.h
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosPageViewController.h"

@interface PhotoViewController : UIViewController

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *photoURL;

@property (nonatomic, weak) PhotosPageViewController *superViewController;

@end
