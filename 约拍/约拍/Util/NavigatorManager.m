//
//  NavigatorManager.m
//  约拍
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "NavigatorManager.h"
#import "ProductsViewController.h"
#import "ProductModel.h"
#import "PaymentViewController.h"
#import "StoreDashboardViewController.h"

@implementation NavigatorManager

+ (void)navigatorBy:(ActionModel *)action viewController:(UIViewController *)viewController
{
    if (action.navigatorType == NavigatorTypeByType || action.navigatorType == NavigatorTypeByStore) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
        ProductsViewController *navigatorToViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ProductsViewController"];
        navigatorToViewController.action = action;
        [viewController.navigationController pushViewController:navigatorToViewController animated:YES];
    } else if (action.navigatorType == NavigatorTypeToPayment) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
        PaymentViewController *navigatorToViewController = [storyBoard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
        navigatorToViewController.action = action;
        [viewController.navigationController pushViewController:navigatorToViewController animated:YES];
    } else if (action.navigatorType == NavigatorTypeToStore) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Store" bundle:nil];
        StoreDashboardViewController *navigatorToViewController = [storyBoard instantiateInitialViewController];
        navigatorToViewController.action = action;
        [viewController.navigationController pushViewController:navigatorToViewController animated:YES];
    }
}

@end
