//
//  OrderCell.m
//  约拍
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "OrderCell.h"
#import "UIImageView+WebCache.h"

@interface OrderCell()

@property (nonatomic, weak) IBOutlet UILabel *productDescriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *productPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *orderStatusLabel;
@property (nonatomic, weak) IBOutlet UIImageView *productImageView;

@end

@implementation OrderCell

- (void)awakeFromNib {
}

- (void)setProductItem:(ProductModel *)product
{
    self.productDescriptionLabel.text = product.productDescription;
    self.productPriceLabel.text = [NSString stringWithFormat:@"¥ %@", @(product.price)];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:product.images.firstObject]];
}

- (void)setOrderStatus:(NSString *)status
{
    self.orderStatusLabel.text = status;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
