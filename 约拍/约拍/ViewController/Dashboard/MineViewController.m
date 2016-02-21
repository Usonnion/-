//
//  MineViewController.m
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (IBAction)storeInvitation:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入邀请码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"进入店铺" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields[0];
        if ([textField.text isEqualToString:@"12345"]) {
            [self goToMyStore:textField.text];
        }
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)goToMyStore:(NSString *)invitationId
{
    ActionModel *action = [[ActionModel alloc] init];
    action.invitationId = invitationId;
    action.navigatorType = NavigatorTypeToStore;
    action.storeId = @"12345";
    StoreModel *store = [[StoreModel alloc] init];
    store.storeId = @"12345";
    [[DiskCacheManager sharedManager] archiveStoreInformation:@[store]];
    [NavigatorManager navigatorBy:action viewController:self];
}

@end
