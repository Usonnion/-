//
//  CommentsCell.m
//  约拍
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CommentsCell.h"
#import "Star.h"

@interface CommentsCell()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *commentsLabel;
@property (nonatomic, weak) IBOutlet UIView *starView;
@property (nonatomic, weak) Star *star;
@property (nonatomic, weak) IBOutlet UILabel *commentTimeLabel;

@end

@implementation CommentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    Star *star = [[Star alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 40.0f)];
    star.font_size = 15.0;
    [self.starView addSubview:star];
    self.star = star;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(CommentModel *)comment
{
    _comment = comment;
    self.nameLabel.text = comment.customer.customerName;
    self.commentsLabel.text = comment.comment;
    self.star.show_star = comment.score;
    self.commentTimeLabel.text = [NSString dateStringByDate:comment.createdDate];
}

@end
