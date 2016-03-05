//
//  HTTPSessionManager.h
//  约拍
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HTTPSessionManager: AFHTTPSessionManager

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSString *baseUrlStr;

+ (HTTPSessionManager *)sharedManager;

@end
