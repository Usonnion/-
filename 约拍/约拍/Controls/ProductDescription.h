//
//  ProductDescription.h
//  约拍
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

static CGFloat productDescriptionHeight = 94.0;

@interface ProductDescription : UIView

+ (ProductDescription *)productDescriptionWithProduct:(ProductModel *)product;

@end
