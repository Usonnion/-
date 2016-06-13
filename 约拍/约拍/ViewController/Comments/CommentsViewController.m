//
//  CommentsViewController.m
//  约拍
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentsCell.h"

@interface CommentsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentsCell" bundle:nil] forCellReuseIdentifier:@"CommentsCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsCell"];
    return cell;
}

#pragma UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0;
}

@end
