//
//  LoadingIconManager.m
//  约拍
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "LoadingManager.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"

@interface LoadingManager()

@property (nonatomic, weak) MBProgressHUD *processView;
@property (nonatomic, weak) UIView *superView;
@property (nonatomic, weak) UIActivityIndicatorView *normalProcessView;

@end

@implementation LoadingManager

+ (LoadingManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static LoadingManager *sharedManager;
    dispatch_once(&onceToken, ^{
        sharedManager = [[LoadingManager alloc] init];
    });
    return sharedManager;
}

- (void)showSuccessMessage:(NSString *)message toView:(UIView *)view
{
    [MBProgressHUD showSuccess:message toView:view];
}

- (void)showError:(NSString *)message toView:(UIView *)view
{
    [MBProgressHUD showError:message toView:view];
}

- (void)showLoading:(UIView *)view
{
    UIActivityIndicatorView *normalProcessView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(view.bounds.size.width / 2, view.bounds.size.height / 2, 15.0, 15.0)];
    [normalProcessView startAnimating];
    [view addSubview:normalProcessView];
    self.normalProcessView = normalProcessView;
}

- (void)showLoadingWithBlockUI:(UIView *)view description:(NSString *)description
{
    self.processView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (![NSString isNilOrEmpty:description]) {
        self.processView.labelText = description;
    }
    self.superView = view;
}

- (void)hideLoadingWithmessage:(NSString *)message success:(BOOL)success
{
    if (self.processView) {
        [self.processView hide:YES];
        if (![NSString isNilOrEmpty:message]) {
            if (success) {
                [MBProgressHUD showSuccess:message toView:self.superView];
            } else {
                [MBProgressHUD showError:message toView:self.superView];
            }
        }
    }
    
    if (self.normalProcessView) {
        [self.normalProcessView removeFromSuperview];
    }
}

@end
