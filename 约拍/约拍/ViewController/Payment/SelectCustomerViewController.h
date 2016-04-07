//
//  SelectCustomerViewController.h
//  约拍
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "BaseController.h"

@interface SelectCustomerViewController : BaseController

@property (nonatomic, strong) NSArray *customers;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, copy) void(^selected)(NSInteger selectedIndex);

@end
