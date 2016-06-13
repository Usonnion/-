//
//  CommentsView.h
//  约拍
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsView : UIView

@property (nonatomic, assign) CGFloat height;
+ (CommentsView *)commentsViewWithComment:(id)comment;

@end
