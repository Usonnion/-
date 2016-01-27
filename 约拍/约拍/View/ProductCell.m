//
//  ProductCollectionViewCell.m
//  约拍
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductCell.h"
#import "ProductModel.h"
#import "ActionModel.h"
#import "UIImageView+WebCache.h"

@interface ProductCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSString *productId;

@end

@implementation ProductCell

- (void)setContentData:(id)contentModel
{
    ProductModel *product = (ProductModel *)contentModel;
    NSURL *imageUrl = [NSURL URLWithString:product.images.firstObject];
    [self.imageView sd_setImageWithURL:imageUrl];
    self.productId = product.productId;
}

- (IBAction)buyButtonPressed:(id)sender
{
//    [self.delegate buyProduct:self.product];
    ActionModel *action = [[ActionModel alloc] init];
    action.navigatorType = NavigatorTypeToPayment;
    action.productId = self.productId;
    [self.delegate buyProduct:action];
}

@end
