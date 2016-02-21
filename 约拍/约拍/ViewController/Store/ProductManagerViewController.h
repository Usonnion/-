//
//  ProductManagerViewController.h
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "MyProductsViewController.h"

@interface ProductManagerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) ProductModel *product;
@property (nonatomic, weak) MyProductsViewController *myProductsViewController;

@end
