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
#import "CommentViewController.h"
#import "MJRefresh.h"

@interface ShoppingCarts() <UITableViewDataSource, UITableViewDelegate, OrderDelegate>

@property (nonatomic, weak) IBOutlet UILabel *noOrdersLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *orders;

@end

@implementation ShoppingCarts {
    UIPopoverController *popoverViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, screenBounds.size.width, 0, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"订单信息";
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:NO];
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
    orderCell.isCustomerOrder = YES;
    [orderCell setProductItem:((OrderModel *)cellData).product];
    [orderCell setOrderStatus:((OrderModel *)cellData).status];
    [orderCell setCustomerItem:cellData];
    orderCell.delegate = self;
    orderCell.indexPath = indexPath;
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

#pragma mark - OrderDelegate

- (void)customeAction:(ActionType)actionType WithIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *order = self.orders[indexPath.row];
    if (actionType == ActionTypeWaitingForComments) {
        UINib *nib = [UINib nibWithNibName:@"CommentViewController" bundle:nil];
        CommentViewController *commentViewController = [nib instantiateWithOwner:self options:nil][0];
        commentViewController.order = order;
        [self presentViewController:commentViewController animated:YES completion:nil];
    } else if (actionType == ActionTypeCompleted) {
        order.status = @"WAITINGFORCOMMENTS";
        [[LoadingManager sharedManager] showLoading:self.view];
        [[[OrderBLL alloc] init] updateOrderStatus:order Success:^{
            [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
        } failure:^{
            [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:YES];
        }];
    }
}

- (void)refreshData
{
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
        [self.tableView headerEndRefreshing];
    } failure:^{
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"获取订单失败，请重试。" success:NO];
        [self.tableView headerEndRefreshing];
    }];
}

- (void)headerRereshing
{
    [self refreshData];
}

@end
