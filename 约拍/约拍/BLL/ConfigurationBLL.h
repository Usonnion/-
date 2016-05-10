//
//  ConfigurationBLL.h
//  约拍
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigurationBLL : NSObject

- (void)getConfigurationSuccess:(void (^)())success failure:(void (^)())failure;

@end
