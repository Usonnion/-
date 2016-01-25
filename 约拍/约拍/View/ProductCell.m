//
//  ProductCollectionViewCell.m
//  约拍
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductCell.h"
#import "ProductModel.h"
#import "UIImageView+WebCache.h"

@interface ProductCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation ProductCell

- (void)setContentData:(id)contentModel
{
    ProductModel *product = (ProductModel *)contentModel;
    NSURL *imageUrl = [NSURL URLWithString:product.images.firstObject];
    [self.imageView sd_setImageWithURL:imageUrl];
}


@end
