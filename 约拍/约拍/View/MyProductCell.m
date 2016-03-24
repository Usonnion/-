//
//  MyProductCell.m
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "MyProductCell.h"
#import "ProductModel.h"
#import "UIImageView+WebCache.h"

@interface MyProductCell()

@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UILabel *productNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *productPriceLabel;

@property (nonatomic, weak) ProductModel *product;

@end

@implementation MyProductCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setContentData:(id)contentModel
{
    ProductModel *product = contentModel;
    self.productNameLabel.text = product.productDescription;
    self.productPriceLabel.text = [NSString stringWithFormat:@"¥ %@", @(product.price)];
    id firstImage = product.images.firstObject;
    if ([firstImage isKindOfClass:[UIImage class]]) {
        [self.productImageView setImage:firstImage];
    } else if ([firstImage isKindOfClass:[NSString class]]) {
        [self.productImageView sd_setImageWithURL:[NSURL URLWithString:firstImage]];
    }
    self.product = product;
}

- (IBAction)previewButtonPressed
{
    ActionModel *action = [[ActionModel alloc] init];
    action.navigatorType = NavigatorTypeToPayment;
    action.productId = self.product.productId;
    if ([self.delegate respondsToSelector:@selector(previewProduct:)]) {
        [self.delegate previewProduct:action];
    }
}

@end
