//
//  PageControlViewController.h
//  约拍
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageControlViewControllerDelegate <NSObject>

- (void)pagePressed:(NSInteger)page;

@end

@interface PageControlViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) id<PageControlViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL scrollCircle;
@property (nonatomic, assign) BOOL autoScroll;

+ (PageControlViewController *)pageControlViewControllerWithFrame:(CGRect)frame images:(NSArray *)images scrollCircle:(BOOL)scrollCircle autoScroll:(BOOL)autoScroll;
- (void)setCurrentPage:(NSInteger)page;

@end
