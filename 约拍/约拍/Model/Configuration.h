//
//  Configuration.h
//  约拍
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

+ (NSArray *)fromArray:(NSDictionary *)jsonArray;

@end
