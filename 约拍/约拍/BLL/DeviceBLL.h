//
//  DeviceBLL.h
//  约拍
//
//  Created by apple on 16/3/27.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceBLL : NSObject

- (void)registerDevice:(NSString *)deviceIdentity Success:(void (^)())success failure:(void (^)())failure;

@end
