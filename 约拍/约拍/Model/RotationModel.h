//
//  RotationModel.h
//  约拍
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RotationModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *productId;

+ (NSArray *)fromArray:(NSArray *)jsonArray;

@end
