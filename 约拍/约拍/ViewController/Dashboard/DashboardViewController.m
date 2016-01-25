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
    
    NSArray *productTypes/Users/apple/Desktop/约拍/约拍/约拍.xcodeproj/project.pbxproj
/Users/apple/Desktop/约拍/约拍/约拍.xcodeproj/project.xcworkspace/xcuserdata/apple.xcuserdatad/UserInterfaceState.xcuserstate
/Users/apple/Desktop/约拍/约拍/约拍/AppDelegate.h
/Users/apple/Desktop/约拍/约拍/约拍/AppDelegate.m
/Users/apple/Desktop/约拍/约拍/约拍/ConstFile.h
/Users/apple/Desktop/约拍/约拍/约拍/DataCache/ArtisticPhoto.xcdatamodeld/ArtisticPhoto.xcdatamodel/contents
/Users/apple/Desktop/约拍/约拍/约拍/DataCache/DiskCacheManager.h
/Users/apple/Desktop/约拍/约拍/约拍/DataCache/DiskCacheManager.m
/Users/apple/Desktop/约拍/约拍/约拍/DataCache/Product.h
/Users/apple/Desktop/约拍/约拍/约拍/DataCache/Product.m
/Users/apple/Desktop/约拍/约拍/约拍/Info.plist
/Users/apple/Desktop/约拍/约拍/约拍/Model/ActionModel.h
/Users/apple/Desktop/约拍/约拍/约拍/Model/ProductModel.h
/Users/apple/Desktop/约拍/约拍/约拍/Model/ProductModel.m
/Users/apple/Desktop/约拍/约拍/约拍/Model/StoreModel.h
/Users/apple/Desktop/约拍/约拍/约拍/Model/StoreModel.m
/Users/apple/Desktop/约拍/约拍/约拍/Util/NavigatorManager.h
/Users/apple/Desktop/约拍/约拍/约拍/Util/NavigatorManager.m
/Users/apple/Desktop/约拍/约拍/约拍/View/PhotoCell.m
/Users/apple/Desktop/约拍/约拍/约拍/View/ProductCell.m
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Dashboard/Dashboard.storyboard
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Dashboard/DashboardViewController.m
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Dashboard/PageControlViewController.m
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Product/PhotoViewController.m
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Product/PhotosPageViewController.m
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Product/PhotosViewController.h
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Product/PhotosViewController.m
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Product/Product.storyboard
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Product/ProductsViewController.h
/Users/apple/Desktop/约拍/约拍/约拍/ViewController/Product/ProductsViewController.m
/Users/apple/Desktop/约拍/约拍/约拍.xcodeproj/project.xcworkspace/xcuserdata/apple.xcuserdatad/WorkspaceSettings.xcsettings
/Users/apple/Desktop/约拍/约拍/约拍/Default.jpg
/Users/apple/Desktop/约拍/约拍/约拍/PrefixHeader.pch = @[@"KidsPhoto", @"WeddingPhoto", @"PersonalPhoto", @"Others"];
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
