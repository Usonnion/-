//
//  StoreManagerViewController.m
//  约拍
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "StoreManagerViewController.h"

@interface StoreManagerViewController ()

@property (nonatomic, weak) IBOutlet UITextField *storeNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *storeAddressTextField;
@property (nonatomic, weak) IBOutlet UITextField *storePhoneTextField;
@property (nonatomic, weak) IBOutlet UIButton *editStorePhotoButton;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *editBarButtonItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *completedBarButtonItem;

@end

@implementation StoreManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self endEditting];
}

#pragma mark - Actions

#pragma mark - Private methods

- (void)BeginEditting
{
    self.storeNameTextField.enabled = YES;
    self.storeAddressTextField.enabled = YES;
    self.storePhoneTextField.enabled = YES;
    self.editStorePhotoButton.hidden = NO;
    self.storeNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.storeAddressTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.storePhoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    UIBarButtonItem *completedBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(endEditting)];
    self.navigationItem.rightBarButtonItem = completedBarButtonItem;
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(endEditting)];
    self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
}

- (void)endEditting
{
    self.storeNameTextField.enabled = NO;
    self.storeAddressTextField.enabled = NO;
    self.storePhoneTextField.enabled = NO;
    self.editStorePhotoButton.hidden = YES;
    self.storeNameTextField.borderStyle = UITextBorderStyleNone;
    self.storeAddressTextField.borderStyle = UITextBorderStyleNone;
    self.storePhoneTextField.borderStyle = UITextBorderStyleNone;
    
    [self.editBarButtonItem setTitle:@"编辑"];
    [self.completedBarButtonItem setTitle:@""];
    self.completedBarButtonItem.enabled = NO;
    
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(BeginEditting)];
    self.navigationItem.leftBarButtonItem = editBarButtonItem;
    self.navigationItem.rightBarButtonItem = nil;
}

@end
