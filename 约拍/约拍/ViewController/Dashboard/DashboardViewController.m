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
#import "ConfigurationBLL.h"
#import "ProductTypeModel.h"
#import "RotationModel.h"
#import "MJRefresh.h"

NSString *kActionStyleSummary = @"ActionStyleSummary";
NSString *kActionStyleAction = @"ActionStyleAction";

@interface DashboardViewController()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<ActionModel *> *actions;
@property (nonatomic, assign) BOOL loadingStoreDone;
@property (nonatomic, assign) BOOL loadingPorudctDone;
@property (nonatomic, assign) BOOL loadingConfigDone;

@end

@implementation DashboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.tableView.estimatedRowHeight = 40;
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionSummaryCell" bundle:nil] forCellReuseIdentifier:@"ActionSummaryCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionCell" bundle:nil] forCellReuseIdentifier:@"ActionCell"];
    
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.tabBarController.view description:@"加载数据中"];
    [self loadData];
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:NO];
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

- (void)setContent
{
    NSMutableArray *actions = [NSMutableArray new];
    ActionModel *action1 = [[ActionModel alloc] init];
    action1.title = @"摄影分类";
    action1.style = kActionStyleSummary;
    action1.cellIdentifier = @"ActionSummaryCell";
    [actions addObject:action1];
    
    for (ProductTypeModel *productType  in [DiskCacheManager sharedManager].productTypes) {
        ActionModel *action = [[ActionModel alloc] init];
        action.title = productType.productTypeName;
        action.style = kActionStyleAction;
        action.navigatorType = NavigatorTypeByType;
        action.cellIdentifier = @"ActionCell";
        action.productType = productType.productTypeName;
        [actions addObject:action];
    }
    self.actions = actions;
    
    NSMutableArray *images = [NSMutableArray new];
    for (RotationModel *rotation in [DiskCacheManager sharedManager].rotations) {
        [images addObject:rotation.imageUrl];
    }
    
    PageControlViewController *pageViewController = [PageControlViewController pageControlViewControllerWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width / 2) images:images scrollCircle:YES autoScroll:YES];
    [self addChildViewController:pageViewController];
    UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width / 2)];
    tableViewHeaderView.backgroundColor = [UIColor redColor];
    [tableViewHeaderView addSubview:pageViewController.view];
    self.tableView.tableHeaderView = tableViewHeaderView;
    
    [self.tableView reloadData];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    self.loadingStoreDone = NO;
    self.loadingPorudctDone = NO;
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
    
    [[[ConfigurationBLL alloc] init] getConfigurationSuccess:^{
        weakSelf.loadingConfigDone = YES;
        [weakSelf checkDataLoading];
    } failure:^{
        weakSelf.loadingConfigDone = YES;
        [weakSelf checkDataLoading];
    }];
}

- (void)checkDataLoading
{
    if (self.loadingPorudctDone && self.loadingStoreDone && self.loadingConfigDone) {
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"加载数据完成" success:YES];
        [self setContent];
        [self.tableView headerEndRefreshing];
    }
}

- (void)headerRereshing
{
    [self loadData];
}

@end
