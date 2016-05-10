//
//  ProductTypeModel.m
//  约拍
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductTypeModel.h"

@implementation ProductTypeModel

+ (NSArray *)fromArray:(NSArray *)jsonArray
{
    if (jsonArray && jsonArray.count) {
        NSMutableArray *productTypes = [NSMutableArray new];
        for (NSDictionary *json in jsonArray) {
            ProductTypeModel *productType = [[ProductTypeModel alloc] init];
            productType.id = [json integerForKey:@"Id"];
            productType.productTypeName = [json stringForKey:@"ProductTypeName"];
            [productTypes addObject:productType];
        }
        return productTypes;
    }
    
    return [ProductTypeModel getDetaultProductTypes];
}

+ (NSArray *)getDetaultProductTypes
{
    ProductTypeModel *productType1 = [[ProductTypeModel alloc] init];
    productType1.id = 0;
    productType1.productTypeName = @"";
    ProductTypeModel *productType2 = [[ProductTypeModel alloc] init];
    productType2.id = 1;
    productType2.productTypeName = @"";
    ProductTypeModel *productType3 = [[ProductTypeModel alloc] init];
    productType3.id = 2;
    productType3.productTypeName = @"";
    ProductTypeModel *productType4 = [[ProductTypeModel alloc] init];
    productType4.id = 4;
    productType4.productTypeName = @"";
    
    NSMutableArray *productTypes = [NSMutableArray new];
    [productTypes addObject:productType1];
    [productTypes addObject:productType2];
    [productTypes addObject:productType3];
    [productTypes addObject:productType4];
    
    return productTypes;
}

@end
