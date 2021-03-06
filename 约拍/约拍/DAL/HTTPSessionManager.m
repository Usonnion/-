//
//  HTTPSessionManager.m
//  约拍
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "HTTPSessionManager.h"
#import "DeviceBLL.h"

@implementation HTTPSessionManager

+ (HTTPSessionManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static HTTPSessionManager *sharedManager;
    dispatch_once(&onceToken, ^{
        NSString *configFile = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
        NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithContentsOfFile:configFile];
        sharedManager = [[HTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[root stringForKey:@"ServiceUrl"]]];
        sharedManager.token = [root stringForKey:@"Token"];
        sharedManager.baseUrlStr = [root stringForKey:@"ServiceUrl"];
        
        AFHTTPRequestSerializer *requestSerializer = [[AFJSONRequestSerializer alloc] init];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [requestSerializer setValue:[UICKeyChainStore stringForKey:@"DeviceIdentity"] forHTTPHeaderField:@"DeviceIdentity"];
        requestSerializer.timeoutInterval = 20000;
        sharedManager.requestSerializer = requestSerializer;
        
        AFHTTPResponseSerializer *responseSerializer = [[AFJSONResponseSerializer alloc] init];
        sharedManager.responseSerializer = responseSerializer;
    });
    return sharedManager;
}

@end
