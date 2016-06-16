//
//  StoreOrderViewController.m
//  约拍
//
//  Created by apple on 16/4/10.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "StoreOrderViewController.h"
#import "OrderCell.h"
#import "OrderBLL.h"
#import "MJRefresh.h"

@interface StoreOrderViewController () <OrderDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *noOrdersLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *orders;

@end

@implementation StoreOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, screenBounds.size.width, 0, 0);
    self.title = @"订单信息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.view description:nil];
    [self refreshData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellData = [self.orders objectByIndex:indexPath.row];
    if (!cellData) return [UITableViewCell new];
    OrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    [orderCell setProductItem:((OrderModel *)cellData).product];
    [orderCell setOrderStatus:((OrderModel *)cellData).status];
    [orderCell setCustomerItem:cellData];
    orderCell.isCustomerOrder = NO;
    orderCell.indexPath = indexPath;
    orderCell.delegate = self;
    orderCell.superViewController = self;
    return orderCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id cellData = [self.orders objectByIndex:indexPath.row];
    if (!cellData) return;
    ActionModel *action = [[ActionModel alloc] init];
    action.productId = ((OrderModel *)cellData).productId;
    action.navigatorType = NavigatorTypeToPayment;
    [NavigatorManager navigatorBy:action viewController:self];
}

- (void)refreshData
{
    __weak typeof(self) weakSelf = self;
    
    [[[OrderBLL alloc] init] getAllStoreOrdersSuccess:^(NSArray *result) {
        NSMutableArray *array = [NSMutableArray new];
        for (NSDictionary *orderDic in result) {
            OrderModel *order = [OrderModel fromDictionary:orderDic[@"Order"]];
            order.customer = [CustomerModel fromDictionary:orderDic[@"Customer"]];
            [array addObject:order];
        }
        weakSelf.orders = array;
        [weakSelf.tableView reloadData];
        weakSelf.noOrdersLabel.hidden = array.count;
        [self.tableView headerEndRefreshing];
        [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
    } failure:^{
        weakSelf.noOrdersLabel.hidden = NO;
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"获取订单失败，请重试。" success:NO];
        [self.tableView headerEndRefreshing];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - ConfirmOrderDelegate

- (void)confirmOrderWithIndexPath:(NSIndexPath *)indexPath
{
    id cellData = [self.orders objectByIndex:indexPath.row];
    OrderModel *order = (OrderModel *)cellData;
    order.status = @"RECEIVED";
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.view description:nil];
    __weak typeof(self) weakSelf = self;
    if (cellData) {
        [[[OrderBLL alloc] init] updateOrderStatus:order Success:^{
            [weakSelf.tableView reloadData];
            [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
        } failure:^{
            [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
        }];
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    NSString *message;
    if (result == MessageComposeResultCancelled) {
        return;
    }
    
    if (result == MessageComposeResultSent) {
        message = @"发送成功。";
    } else {
        message = @"发送失败。";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)headerRereshing
{
    [self refreshData];
}

@end
