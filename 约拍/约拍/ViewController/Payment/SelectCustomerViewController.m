//
//  SelectCustomerViewController.m
//  约拍
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "SelectCustomerViewController.h"
#import "CustomerCell.h"

@interface SelectCustomerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation SelectCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"请选择预定人";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerCell" bundle:nil] forCellReuseIdentifier:@"CustomerCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.customers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerCell"];
    [cell setCustomer:self.customers[indexPath.row]];
    [cell setCustomerSelected:indexPath.row == self.selectIndex];
    
    return cell;
}

#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selected(indexPath.row);
}

@end
