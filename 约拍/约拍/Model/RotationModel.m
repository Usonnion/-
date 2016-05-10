//
//  RotationModel.m
//  约拍
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "RotationModel.h"

@implementation RotationModel

+ (NSArray *)fromArray:(NSArray *)jsonArray
{
    if (jsonArray && jsonArray.count) {
        NSMutableArray *rotations = [NSMutableArray new];
        for (NSDictionary *json in jsonArray) {
            RotationModel *rotation = [[RotationModel alloc] init];
            rotation.id = [json integerForKey:@"Id"];
            rotation.imageUrl = [json stringForKey:@"ImageUrl"];
            rotation.productId = [json stringForKey:@"ProductId"];
            [rotations addObject:rotation];
        }
        return rotations;
    }
    
    return [RotationModel getDefaultsRotations];
}

+ (NSArray *)getDefaultsRotations
{
    RotationModel *rotation1 = [[RotationModel alloc] init];
    rotation1.id = 0;
    rotation1.imageUrl = @"http://i4.tietuku.com/ed6c25f8d0c526f8.jpg";
    rotation1.productId = @"";
    RotationModel *rotation2 = [[RotationModel alloc] init];
    rotation2.id = 1;
    rotation2.imageUrl = @"http://i11.tietuku.com/59a5e776cdb0a07e.jpg";
    rotation2.productId = @"";
    RotationModel *rotation3 = [[RotationModel alloc] init];
    rotation3.id = 2;
    rotation3.imageUrl = @"http://i12.tietuku.com/6255d9b25b0e6fa9.jpg";
    rotation3.productId = @"";
    
    NSMutableArray *rotations = [NSMutableArray new];
    [rotations addObject:rotation1];
    [rotations addObject:rotation2];
    [rotations addObject:rotation3];
    return rotations;
}

@end
