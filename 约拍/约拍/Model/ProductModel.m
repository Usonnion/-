//
//  ProductModel.m
//  约拍
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

+ (ProductModel *)fromDictionary:(NSDictionary *)dictionary
{
    ProductModel *product = [[ProductModel alloc] init];
    product.storeId = [dictionary stringForKey:@"StoreId"];
    product.productId = [dictionary stringForKey:@"ProductId"];
    product.price = [dictionary doubleForKey:@"Price"];
    product.images = [[dictionary stringForKey:@"Images"] componentsSeparatedByString:@","];
    product.productType = [dictionary objectForKey:@"ProductType"];
    product.productDescription = [dictionary objectForKey:@"ProductDescription"];
    product.updatedTime = [dictionary objectForKey:@"UpdatedTime"];
    return product;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.storeId forKey:@"Product.StoreId"];
    [aCoder encodeObject:self.images forKey:@"Product.Images"];
    [aCoder encodeObject:self.productId forKey:@"Product.ProductId"];
    [aCoder encodeDouble:self.price forKey:@"Product.Price"];
    [aCoder encodeObject:self.productType forKey:@"Product.ProductType"];
    [aCoder encodeObject:self.productDescription forKey:@"Product.ProductDescription"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.storeId = [aDecoder decodeObjectForKey:@"Product.StoreId"];
        self.productId = [aDecoder decodeObjectForKey:@"Product.ProductId"];
        self.productType = [aDecoder decodeObjectForKey:@"Product.ProductType"];
        self.images = [aDecoder decodeObjectForKey:@"Product.Images"];
        self.price = [aDecoder decodeDoubleForKey:@"Product.Price"];
        self.productDescription = [aDecoder decodeObjectForKey:@"Product.ProductDescription"];
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableString *imagesString = [@"" mutableCopy];
    for (NSString *imageString in self.images) {
        NSInteger index= [self.images indexOfObject:imageString];
        if (index) {
            [imagesString appendString:@","];
        }
        [imagesString appendString:imageString];
    }
    return @{@"StoreId":[NSString getEmptyIfNull:self.storeId],
             @"ProductId":[NSString getEmptyIfNull:self.productId],
             @"Price":@(self.price),
             @"ProductType":self.productType,
             @"ProductDescription":self.productDescription,
             @"Images":imagesString};
}

@end
