//
//  ProductsViewController.h
//  约拍
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionModel.h"

@interface ProductsViewController : BaseController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ActionModel *action;

@end
