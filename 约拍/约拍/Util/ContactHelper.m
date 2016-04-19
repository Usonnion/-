//
//  ContactHelper.m
//  约拍
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ContactHelper.h"

@implementation ContactHelper

+ (void)callTo:(NSString *)phoneNumber name:(NSString *)name view:(UIView *)view
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [view addSubview:callWebview];
}

+ (void)messageTo:(NSString *)phoneNumber viewcontroller:(UIViewController<MFMessageComposeViewControllerDelegate> *)superViewController
{
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:phoneNumber];
        controller.body = @"";
        controller.messageComposeDelegate = superViewController;
        
        [superViewController presentViewController:controller animated:YES completion:nil];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"不支持发送信息。" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
        [superViewController presentViewController:alertController animated:YES completion:nil];
    }
}

@end
