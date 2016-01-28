//
//  ProductDescription.m
//  约拍
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductDescription.h"

@interface ProductDescription()

@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end

@implementation ProductDescription

+ (ProductDescription *)productDescriptionWithProduct:(ProductModel *)product
{
    UINib *nib = [UINib nibWithNibName:@"ProductDescription" bundle:nil];
    ProductDescription *productDescription = [nib instantiateWithOwner:self options:nil][0];
    [productDescription setContentWithProduct:product];
    return productDescription;
}

- (void)setContentWithProduct:(ProductModel *)product
{
    self.descriptionLabel.text = product.productDescription;
    self.priceLabel.text = [NSString stringWithFormat:@"%@", @(product.price)];
}



@end