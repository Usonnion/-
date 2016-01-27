//
//  CustomerNavigatorItem.h
//  约拍
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomerNavigatorItemDelegate <NSObject>

@optional
- (void)backButtonPressed;

@end

@interface CustomerNavigatorItem : UIView

@property (nonatomic, weak) id<CustomerNavigatorItemDelegate> delegate;
+ (CustomerNavigatorItem *)customerNavigatorItemWithFrame:(CGRect)frame;

- (void)setOffset:(CGFloat)offset;

@end
