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

@end

@implementation CommentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    Star *star = [[Star alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 40.0f)];
    star.show_star = 89;
    star.font_size = 15;
    [self.starView addSubview:star];
    
    self.nameLabel.text = @"123";
    self.commentsLabel.text = @"很好很好很好很好很好很好很好很好很好很好很好很好，很好很好很好很好很好很好，很好很好很好很好.很好很好很好很好很好很好很好很好很好很好很好很好，很好很好很好很好很好很好，很好很好很好很好.很好很好很好很好很好很好很好很好很好很好很好很好，很好很好很好很好很好很好，很好很好很好很好.很好很好很好很好很好很好很好很好很好很好很好很好，很好很好很好很好很好很好，很好很好很好很好";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
