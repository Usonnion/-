//
//  CommentsView.m
//  约拍
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CommentsView.h"

@interface CommentsView()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *commentsLabel;
@property (nonatomic, weak) IBOutlet UIView *starView;

@end

@implementation CommentsView

+ (CommentsView *)commentsViewWithComment:(id)comment;
{
    UINib *nib = [UINib nibWithNibName:@"CommentsView" bundle:nil];
    CommentsView *commentsView = [nib instantiateWithOwner:self options:nil][0];
    return commentsView;
}

@end
