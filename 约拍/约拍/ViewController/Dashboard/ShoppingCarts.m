//
//  ShoppingCarts.m
//  约拍
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ShoppingCarts.h"
#import "OrderCell.h"

@interface ShoppingCarts()

@property (nonatomic, weak) IBOutlet UILabel *noOrdersLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) NSArray *orders;

@end

@implementation ShoppingCarts

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
//    [storeCell setContentWithStore:self.stores[indexPath.row]];
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
    
//    StoreModel *store = self.stores[indexPath.row];
//    ActionModel *action = [[ActionModel alloc] init];
//    action.storeId = store.storeId;
//    action.navigatorType = NavigatorTypeByStore;
//    [NavigatorManager navigatorBy:action viewController:self];
}

@end
