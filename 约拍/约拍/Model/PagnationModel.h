//
//  PagnationModel.h
//  约拍
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PagnationModel : NSObject

@property (nonatomic, assign) NSInteger page;

- (NSDictionary *)toDictionary;

@end
