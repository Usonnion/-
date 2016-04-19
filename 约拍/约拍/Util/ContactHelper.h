//
//  ContactHelper.h
//  约拍
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface ContactHelper : NSObject

+ (void)callTo:(NSString *)phoneNumber name:(NSString *)name view:(UIView *)view;
+ (void)messageTo:(NSString *)phoneNumber viewcontroller:(UIViewController<MFMessageComposeViewControllerDelegate> *)superViewController;

@end
