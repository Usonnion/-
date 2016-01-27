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

NSString *kActionStyleSummary = @"ActionStyleSummary";
NSString *kActionStyleAction = @"ActionStyleAction";

@interface DashboardViewController()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<ActionModel *> *actions;

@end

@implementation DashboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 40;
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionSummaryCell" bundle:nil] forCellReuseIdentifier:@"ActionSummaryCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionCell" bundle:nil] forCellReuseIdentifier:@"ActionCell"];
    
    PageControlViewController *pageViewController = [PageControlViewController pageControlViewControllerWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width / 2) scrollCircle:YES autoScroll:YES];
    [self addChildViewController:pageViewController];
    UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.width / 2)];
    [tableViewHeaderView addSubview:pageViewController.view];
    self.tableView.tableHeaderView = tableViewHeaderView;
    [self mockData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
    action2.productType = @"KidsPhoto";
    
    ActionModel *action3 = [[ActionModel alloc] init];
    action3.title = @"婚纱摄影";
    action3.style = kActionStyleAction;
    action3.cellIdentifier = @"ActionCell";
    action3.navigatorType = NavigatorTypeByType;
    action3.productType = @"WeddingPhoto";
    
    ActionModel *action4 = [[ActionModel alloc] init];
    action4.title = @"个人写真";
    action4.style = kActionStyleAction;
    action4.cellIdentifier = @"ActionCell";
    action4.navigatorType = NavigatorTypeByType;
    action4.productType = @"PersonalPhoto";
    
    ActionModel *action5 = [[ActionModel alloc] init];
    action5.title = @"其他";
    action5.style = kActionStyleAction;
    action5.cellIdentifier = @"ActionCell";
    action5.navigatorType = NavigatorTypeByType;
    action5.productType = @"Others";
    
    self.actions = @[action1, action2, action3, action4, action5];
    
    NSArray *productTypes = @[@"KidsPhoto", @"WeddingPhoto", @"PersonalPhoto", @"Others"];
    [[DiskCacheManager sharedManager] removeAllProducts];
    NSMutableArray *products = [@[] mutableCopy];
    for (NSInteger storeIndex = 0; storeIndex < 20; storeIndex ++) {
        for (NSInteger productIndex = 10; productIndex < 20; productIndex ++) {
            NSInteger productType = arc4random() % 4;
            NSDictionary *dictionary = @{@"StoreId" : @(storeIndex).stringValue,
                                         @"ProductId" : @(productIndex).stringValue,
                                         @"Price" : @"300",
                                         @"ProductType" : productTypes[productType],
                                         @"Images" : @[@"http://i12.tietuku.com/135887956d5d60e0.jpg",
                                                       @"http://i12.tietuku.com/543908eae4e015d2.jpg",
                                                       @"http://i13.tietuku.com/a1a296b92e03d115.jpg",
                                                       @"http://i12.tietuku.com/3af3552dd6c92720.jpg",
                                                       @"http://i11.tietuku.com/a7710901a121e021.jpg",
                                                       @"http://i12.tietuku.com/cbfddaa457b1f914.jpg"]};
            [products addObject:[ProductModel fromDictionary:dictionary]];
        }
    }
    
    [[DiskCacheManager sharedManager] archiveProductInformation:products];
}

@end
