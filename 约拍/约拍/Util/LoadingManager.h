//
//  LoadingIconManager.h
//  约拍
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingManager : NSString

@property (nonatomic, assign) NSInteger maxLoadingImageCount;
+ (LoadingManager *)sharedManager;

- (void)showError:(NSString *)message toView:(UIView *)view;
- (void)showSuccessMessage:(NSString *)message toView:(UIView *)view;
- (void)showLoadingWithBlockUI:(UIView *)view description:(NSString *)description;
- (void)hideLoadingWithmessage:(NSString *)message success:(BOOL)success;

@end
