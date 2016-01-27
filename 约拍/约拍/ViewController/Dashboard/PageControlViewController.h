//
//  PageControlViewController.h
//  约拍
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControlViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL scrollCircle;
@property (nonatomic, assign) BOOL autoScroll;

+ (PageControlViewController *)pageControlViewControllerWithFrame:(CGRect)frame scrollCircle:(BOOL)scrollCircle autoScroll:(BOOL)autoScroll;

@end
