//
//  ActionCell.m
//  约拍
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ActionCell.h"

@interface ActionCell()

@property (nonatomic, weak) IBOutlet UILabel *actionTitle;

@end

@implementation ActionCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setContentData:(id)contentModel
{
    ActionModel *actionModel = (ActionModel *)contentModel;
    self.actionTitle.text = actionModel.title;
    actionModel.cellHeight = 60.0;
}

@end
