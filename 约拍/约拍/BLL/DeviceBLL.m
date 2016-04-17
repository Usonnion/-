//
//  DeviceBLL.m
//  约拍
//
//  Created by apple on 16/3/27.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "DeviceBLL.h"
#import "HTTPSessionManager.h"

@implementation DeviceBLL

- (void)registerDevice:(NSString *)deviceIdentity Success:(void (^)())success failure:(void (^)())failure
{
    NSString *urlString = [NSString stringWithFormat: @"/api/device?deviceIdentity=%@", deviceIdentity];
    
    [[HTTPSessionManager sharedManager] PUT:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)registerRemoteDevice:(NSString *)token
{
    NSString *urlString = [NSString stringWithFormat: @"/api/device?deviceToken=%@", token];
    
    NSString *deviceIdentity = [[HTTPSessionManager sharedManager].requestSerializer valueForHTTPHeaderField:@"DeviceIdentity"];
    if ([NSString isNilOrEmpty:deviceIdentity]) {
        [self performSelector:@selector(registerRemoteDevice:) withObject:token afterDelay:2.0];
        return;
    }
    [[HTTPSessionManager sharedManager] PUT:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
