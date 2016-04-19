//
//  DashboardViewController.m
//  约拍
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "DashboardViewController.h"
#import "ActionModel.h"
#import "BaseTableViewCell.h"
#import "ActionCell.h"
#import "DiskCacheManager.h"
#import "ProductModel.h"
#import "PageControlViewController.h"
#import "StoreModel.h"
#import "StoreBLL.h"
#import "ProductBLL.h"

NSString *kActionStyleSummary = @"ActionStyleSummary";
NSString *kActionStyleAction = @"ActionStyleAction";

@interface DashboardViewController()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<ActionModel *> *actions;
@property (nonatomic, assign) BOOL loadingStoreDone;
@property (nonatomic, assign) BOOL loadingPorudctDone;

@end

@implementation DashboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.tableView.estimatedRowHeight = 40;
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionSummaryCell" bundle:nil] forCellReuseIdentifier:@"ActionSummaryCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionCell" bundle:nil] forCellReuseIdentifier:@"ActionCell"];
    
    NSArray *images = @[@"http://i4.tietuku.com/ed6c25f8d0c526f8.jpg",
                        @"http://i11.tietuku.com/59a5e776cdb0a07e.jpg",
                        @"http://i12.tietuku.com/6255d9b25b0e6fa9.jpg"];
    PageControlViewController *pageViewController = [PageControlViewController pageControlViewControllerWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width / 2) images:images scrollCircle:YES autoScroll:YES];
    [self addChildViewController:pageViewController];
    UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width / 2)];
    tableViewHeaderView.backgroundColor = [UIColor redColor];
    [tableViewHeaderView addSubview:pageViewController.view];
    self.tableView.tableHeaderView = tableViewHeaderView;
    [self mockData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"首页";
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActionModel *action = [self.actions objectAtIndex:indexPath.row];
    
    BaseTableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:action.cellIdentifier];
    [tableViewCell setContentData:action];
    return tableViewCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActionModel *action = [self.actions objectAtIndex:indexPath.row];
    return action.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActionModel *action = [self.actions objectAtIndex:indexPath.row];
    [NavigatorManager navigatorBy:action viewController:self];
}

#pragma mark - Private methods

- (void)mockData
{
    ActionModel *action1 = [[ActionModel alloc] init];
    action1.title = @"摄影分类";
    action1.style = kActionStyleSummary;
    action1.cellIdentifier = @"ActionSummaryCell";
    
    ActionModel *action2 = [[ActionModel alloc] init];
    action2.title = @"儿童摄影";
    action2.style = kActionStyleAction;
    action2.cellIdentifier = @"ActionCell";
    action2.navigatorType = NavigatorTypeByType;
    action2.productType = @"儿童摄影";
    
    ActionModel *action3 = [[ActionModel alloc] init];
    action3.title = @"婚纱摄影";
    action3.style = kActionStyleAction;
    action3.cellIdentifier = @"ActionCell";
    action3.navigatorType = NavigatorTypeByType;
    action3.productType = @"婚纱摄影";
    
    ActionModel *action4 = [[ActionModel alloc] init];
    action4.title = @"个人写真";
    action4.style = kActionStyleAction;
    action4.cellIdentifier = @"ActionCell";
    action4.navigatorType = NavigatorTypeByType;
    action4.productType = @"个人写真";
    
    ActionModel *action5 = [[ActionModel alloc] init];
    action5.title = @"其他";
    action5.style = kActionStyleAction;
    action5.cellIdentifier = @"ActionCell";
    action5.navigatorType = NavigatorTypeByType;
    action5.productType = @"其他";
    
    self.actions = @[action1, action2, action3, action4, action5];
    
    [[DiskCacheManager sharedManager] removeAllProducts];
    [[DiskCacheManager sharedManager] removeAllStores];
    
    __weak typeof(self) weakSelf = self;
    self.loadingStoreDone = NO;
    self.loadingPorudctDone = NO;
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.tabBarController.view description:@"加载数据中"];
    [[[StoreBLL alloc] init] getAllStoresSuccess:^{
        weakSelf.loadingStoreDone = YES;
        [weakSelf checkDataLoading];
    } failure:^{
         weakSelf.loadingStoreDone = YES;
        [weakSelf checkDataLoading];
    }];
    
    [[[ProductBLL alloc] init] getAllProductsSuccess:^{
        weakSelf.loadingPorudctDone = YES;
        [weakSelf checkDataLoading];
    } failure:^{
        weakSelf.loadingPorudctDone = YES;
        [weakSelf checkDataLoading];
    }];
    
//    NSMutableArray *stores = [@[] mutableCopy];
//    NSMutableArray *products = [@[] mutableCopy];
//    for (NSInteger storeIndex = 0; storeIndex < 20; storeIndex ++) {
//        for (NSInteger productIndex = 10; productIndex < 20; productIndex ++) {
//            NSInteger productType = arc4random() % 4;
//            NSDictionary *dictionary = @{@"StoreId" : @(storeIndex).stringValue,
//                                         @"ProductId" : @(productIndex).stringValue,
//                                         @"Price" : @"300",
//                                         @"ProductType" : productTypes[productType],
//                                         @"ProductDescription" : @"沛县第一婚纱影楼 个人写真",
//                                         @"Images" : @"http://i12.tietuku.com/135887956d5d60e0.jpg, http://i12.tietuku.com/543908eae4e015d2.jpg, http://i13.tietuku.com/a1a296b92e03d115.jpg, http://i12.tietuku.com/3af3552dd6c92720.jpg,http://i11.tietuku.com/a7710901a121e021.jpg, http://i12.tietuku.com/cbfddaa457b1f914.jpg"};
//            [products addObject:[ProductModel fromDictionary:dictionary]];
//        }
//        
//        NSDictionary *storeDictionary = @{@"StoreId" : @(storeIndex).stringValue,
//                                          @"StoreName" : @"星星贝贝儿童摄影",
//                                          @"StoreAddress" : @"汉街南门向西100米",
//                                          @"StoreImage" : @"http://i12.tietuku.com/cbfddaa457b1f914.jpg",
//                                          @"PhoneNumber" : @"18801615551"};
//        [stores addObject:[StoreModel fromDictionary:storeDictionary]];
//    }
    
}

- (void)checkDataLoading
{
    if (self.loadingPorudctDone && self.loadingStoreDone) {
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"加载数据完成" success:YES];
    }
}

@end
