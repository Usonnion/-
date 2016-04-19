//
//  CreateCustomerViewController.m
//  约拍
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CreateCustomerViewController.h"
#import "CustomerModel.h"
#import "CustomerBLL.h"

@interface CreateCustomerViewController ()

@property (nonatomic, weak) IBOutlet UITextField *customerNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *customerPhoneTextField;
@property (nonatomic, weak) IBOutlet UITextView *customerAddressTextView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation CreateCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"创建预定人信息";
    [self setContentStyle];
    
    UIBarButtonItem *completedBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeEditting)];
    self.navigationItem.rightBarButtonItem = completedBarButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditting)];
    [self.scrollView addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setContentStyle
{
    UIColor *color = separatorLineColor;
    self.customerNameTextField.layer.borderColor = color.CGColor;
    self.customerNameTextField.layer.borderWidth = 1;
    self.customerNameTextField.layer.cornerRadius = 5;
    
    self.customerPhoneTextField.layer.borderColor = color.CGColor;
    self.customerPhoneTextField.layer.borderWidth = 1;
    self.customerPhoneTextField.layer.cornerRadius = 5;
    
    self.customerAddressTextView.layer.borderColor = color.CGColor;
    self.customerAddressTextView.layer.borderWidth = 1;
    self.customerAddressTextView.layer.cornerRadius = 5;
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, kbSize.height + 10, 0)];
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)completeEditting
{
    if (![self checkEditting]) {
        return;
    }
    
    [self endEditting];
    
    CustomerModel *customer = [[CustomerModel alloc] init];
    customer.customerId = @"";
    customer.customerName = self.customerNameTextField.text;
    customer.customerPhone = self.customerPhoneTextField.text;
    customer.customerAddress = self.customerAddressTextView.text;
    
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.navigationController.view description:@"正在创建预定人"];
    [[[CustomerBLL alloc] init] updateCustomer:customer success:^(NSDictionary *customerDic) {
        [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"createCustomerSuccess" object:[CustomerModel fromDictionary:customerDic]];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^{
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"创建失败，请重试" success:NO];
    }];
}

- (void)endEditting
{
    [self.view endEditing:YES];
}

- (BOOL)checkEditting
{
    [self endEditting];
    if ([NSString isNilOrEmpty:self.customerNameTextField.text]) {
        [[LoadingManager sharedManager] showError:@"请输入姓名" toView:self.view];
        return NO;
    }
    
    if ([NSString isNilOrEmpty:self.customerPhoneTextField.text]) {
        [[LoadingManager sharedManager] showError:@"请输入电话" toView:self.view];
        return NO;
    }
    
    if ([NSString isNilOrEmpty:self.customerAddressTextView.text]) {
        [[LoadingManager sharedManager] showError:@"请输入地址" toView:self.view];
        return NO;
    }
    
    if (![NSString validatePhone:self.customerPhoneTextField.text]) {
        [[LoadingManager sharedManager] showError:@"请填写正确的手机号" toView:self.view];
        return NO;
    }
    
    return YES;
}

@end
