//
//  StoreViewController.m
//  约拍
//
//  Created by apple on 16/1/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreCell.h"
#import "StoreBLL.h"

@interface StoreViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *stores;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[StoreBLL alloc] init] getAllStores];
    self.stores = [[DiskCacheManager sharedManager] loadAllStores];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:nil] forCellReuseIdentifier:@"StoreCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCell *storeCell = [tableView dequeueReusableCellWithIdentifier:@"StoreCell"];
    [storeCell setContentWithStore:self.stores[indexPath.row]];
    return storeCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return storeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    StoreModel *store = self.stores[indexPath.row];
    ActionModel *action = [[ActionModel alloc] init];
    action.storeId = store.storeId;
    action.navigatorType = NavigatorTypeByStore;
    [NavigatorManager navigatorBy:action viewController:self];
}


@end
