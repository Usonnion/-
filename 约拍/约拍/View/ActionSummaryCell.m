//
//  ActionSummaryCell.m
//  约拍
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ActionSummaryCell.h"
#import "ActionModel.h"

@interface ActionSummaryCell()

@property (nonatomic, weak) IBOutlet UILabel *actionTitle;

@end

@implementation ActionSummaryCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setContentData:(id)contentModel
{
    ActionModel *actionModel = (ActionModel *)contentModel;
    self.actionTitle.text = actionModel.title;
    actionModel.cellHeight = 70.0;
}

@end
