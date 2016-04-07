//
//  CustomerCell.h
//  约拍
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"

@interface CustomerCell : UITableViewCell

- (void)setCustomer:(CustomerModel *)customer;
- (void)setCustomerSelected:(BOOL)selected;

@end
