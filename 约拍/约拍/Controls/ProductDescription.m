//
//  ProductDescription.m
//  约拍
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductDescription.h"

@implementation ProductDescription

+ (ProductDescription *)productDescriptionWithProduct:(ProductModel *)product
{
    UINib *nib = [UINib nibWithNibName:@"ProductDescription" bundle:nil];
    ProductDescription *productDescription = [nib instantiateWithOwner:self options:nil][0];
    return productDescription;
}


@end