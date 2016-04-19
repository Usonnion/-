//
//  BadgeBLL.h
//  约拍
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BadgeBLL : NSObject

- (void)getBadgeSuccess:(void (^)())success failure:(void (^)())failure;

@end
