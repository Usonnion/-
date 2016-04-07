//
//  CreateOrderViewController.m
//  约拍
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CreateOrderViewController.h"
#import "CustomerBLL.h"
#import "OrderModel.h"
#import "OrderBLL.h"

@interface CreateOrderViewController ()

@property (nonatomic, weak) IBOutlet UILabel *customerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *customerPhoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *customerAddressLabel;

@property (nonatomic, weak) IBOutlet UILabel *orderDateLabel;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *customers;
@property (nonatomic, strong) CustomerBLL *customerBLLInstance;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation CreateOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.hidden = YES;
    self.orderDateLabel.text = [NSString stringByDate:[NSDate new]];
    [self setContentData];
    self.title = @"创建订单";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(createOrder)];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:gesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createCustomerSuccess:) name:@"createCustomerSuccess" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - actions

- (IBAction)datePickerValueChanged:(UIDatePicker *)picker
{
    //self.customer.orderDate = picker.date;
    self.orderDateLabel.text = [NSString stringByDate:picker.date];
}

#pragma mark - private methods

- (void)setContentData
{
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.view description:nil];
    self.customerBLLInstance = [[CustomerBLL alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [self.customerBLLInstance getAllCustomers:^(NSArray *customers) {
        NSMutableArray *customerArrary = [NSMutableArray new];
        if (!customers.count) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有设置预定人信息， 请点击这里设置！" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController pushViewController:[weakSelf.storyboard instantiateViewControllerWithIdentifier:@"CreateCustomerViewController"] animated:YES];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            for (NSDictionary *customerDic in customers) {
                CustomerModel *customer = [CustomerModel fromDictionary:customerDic];
                [customerArrary addObject:customer];
            }
            weakSelf.customers = customerArrary;
            self.selectedIndex = 0;
            [weakSelf setContentUI];
        }
        [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
    } failure:^{
        [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
    }];
}

- (void)createOrder
{
    OrderModel *order = [[OrderModel alloc] init];
    order.customerId = ((CustomerModel *)self.customers[self.selectedIndex]).customerId;
    order.productId = self.product.productId;
    order.expectedTime = self.datePicker.date;
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.view description:@"正在创建订单，请稍等。"];
    [[[OrderBLL alloc] init] createOrder:order success:^{
        [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^{
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"创建订单失败，请稍后重试。" success:NO];
    }];
}

- (void)endEdit
{
    [self.view endEditing:YES];
}

- (void)setContentUI
{
    self.scrollView.hidden = NO;
    self.datePicker.minimumDate = [NSDate new];
    
    CustomerModel *selectedCustomer = self.customers[self.selectedIndex];
    self.customerNameLabel.text = selectedCustomer.customerName;
    self.customerPhoneLabel.text = selectedCustomer.customerPhone;
    self.customerAddressLabel.text = selectedCustomer.customerAddress;
}

- (void)createCustomerSuccess:(NSNotification *)notification
{
    CustomerModel *customer = notification.object;
    NSMutableArray *array = [NSMutableArray new];
    [array insertObject:customer atIndex:0];
    self.customers = array;
    self.selectedIndex = 0;
}

@end
