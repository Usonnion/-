//
//  ShoppingCarts.m
//  约拍
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ShoppingCarts.h"
#import "OrderCell.h"
#import "OrderBLL.h"

@interface ShoppingCarts() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *noOrdersLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *orders;

@end

@implementation ShoppingCarts

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, screenBounds.size.width, 0, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"订单信息";
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:NO];
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
    orderCell.isCustomerOrder = YES;
    return orderCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
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
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.view description:nil];
    __block typeof(self) weakSelf = self;
    [[[OrderBLL alloc] init] getAllOrdersSuccess:^(NSArray *result) {
        NSMutableArray *array = [NSMutableArray new];
        for (NSDictionary *orderDic in result) {
            OrderModel *order = [OrderModel fromDictionary:orderDic];
            [array addObject:order];
        }
        weakSelf.orders = array;
        [weakSelf.tableView reloadData];
        weakSelf.noOrdersLabel.hidden = array.count;
        [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
    } failure:^{
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"获取订单失败，请重试。" success:NO];
    }];
}

@end
