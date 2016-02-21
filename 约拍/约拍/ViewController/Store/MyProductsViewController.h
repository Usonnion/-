//
//  MyProductsViewController.h
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProductsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *storeId;

- (void)editProductSuccess:(ProductModel *)product;

@end
