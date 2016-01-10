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
    
    ActionModel *action3 = [[ActionModel alloc] init];
    action3.title = @"婚纱摄影";
    action3.style = kActionStyleAction;
    action3.cellIdentifier = @"ActionCell";
    
    ActionModel *action4 = [[ActionModel alloc] init];
    action4.title = @"个人写真";
    action4.style = kActionStyleAction;
    action4.cellIdentifier = @"ActionCell";
    
    ActionModel *action5 = [[ActionModel alloc] init];
    action5.title = @"其他";
    action5.style = kActionStyleAction;
    action5.cellIdentifier = @"ActionCell";
    
    self.actions = @[action1, action2, action3, action4, action5];
}

@end
