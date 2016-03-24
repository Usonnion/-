//
//  OrderCell.h
//  约拍
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

- (void)setProductItem:(ProductModel *)product;
- (void)setOrderStatus:(NSString *)status;

@end
