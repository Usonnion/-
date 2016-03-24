//
//  CreateOrderViewController.m
//  约拍
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CreateOrderViewController.h"
#import "CustomerModel.h"

@interface CreateOrderViewController ()

@property (nonatomic, weak) IBOutlet UITextField *customerNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *customerPhoneTextField;
@property (nonatomic, weak) IBOutlet UILabel *orderDateLabel;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, strong) CustomerModel *customer;

@end

@implementation CreateOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customer = [[CustomerModel alloc] init];
    self.customer.customerName = @"111";
    self.customer.customerPhone = @"222";
    self.customer.orderDate = [NSDate new];
    [self setContentData];
    self.title = @"创建订单";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(createOrder)];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:gesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions

- (IBAction)datePickerValueChanged:(UIDatePicker *)picker
{
    self.customer.orderDate = picker.date;
    self.orderDateLabel.text = [NSString stringByDate:self.customer.orderDate];
}

- (IBAction)beginEditOrderDate:(id)sender
{
    [self.view endEditing:YES];
    self.datePicker.hidden = NO;
}

#pragma mark - private methods

- (void)setContentData
{
    self.customerNameTextField.text = self.customer.customerName;
    self.customerPhoneTextField.text = self.customer.customerPhone;
    self.orderDateLabel.text = [NSString stringByDate:self.customer.orderDate];
    self.datePicker.minimumDate = [NSDate new];
    self.datePicker.hidden = YES;
    [self.customerNameTextField becomeFirstResponder];
}

- (void)createOrder
{
    
}

- (void)endEdit
{
    [self.view endEditing:YES];
    self.datePicker.hidden = YES;
}

@end
