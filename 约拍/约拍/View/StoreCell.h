//
//  StoreCell.h
//  约拍
//
//  Created by apple on 16/1/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

static CGFloat storeCellHeight = 120.0;

@interface StoreCell : UITableViewCell

- (void)setContentWithStore:(StoreModel *)store;

@end
