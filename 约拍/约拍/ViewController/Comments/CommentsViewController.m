//
//  CommentsViewController.m
//  约拍
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentsCell.h"
#import "CommentsBLL.h"
#import "CommentModel.h"
#import "MJRefresh.h"

@interface CommentsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *noDataLabel;

@property (nonatomic, strong) CommentsBLL *commentsBLLInstance;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, assign) NSInteger page;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentsCell" bundle:nil] forCellReuseIdentifier:@"CommentsCell"];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, screenBounds.size.width, 0, 0);
    self.tableView.estimatedRowHeight = 110.0;
    
    self.commentsBLLInstance = [[CommentsBLL alloc] init];
    
    [[LoadingManager sharedManager] showLoading:self.view];
    [self refreshData:1];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsCell"];
    cell.comment = self.comments[indexPath.row];
    return cell;
}

- (void)refreshData:(NSInteger)page
{
    self.page = page;
    [self.commentsBLLInstance getComments:self.action.productId page:page success:^(NSArray *json) {
        NSMutableArray *comments;
        if (self.page == 1) {
            comments = [NSMutableArray new];
            if (!json) {
                self.noDataLabel.hidden = NO;
            } else if (json.count == 0) {
                self.noDataLabel.hidden = NO;
            } else if (json.count >= 20) {
                [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
                self.page++;
            }
        } else {
            comments = [self.comments mutableCopy];
            if (json.count < 20) {
                [self.tableView footerEndRefreshing];
                [self.tableView removeFooter];
            } else {
                self.page++;
            }
        }
        for (NSDictionary *commentDic in json) {
            [comments addObject:[CommentModel fromDictionary:commentDic]];
        }
        self.comments = comments;
        [self.tableView reloadData];
        self.noDataLabel.hidden = YES;
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:NO];
    } failure:^{
        self.noDataLabel.hidden = NO;
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [[LoadingManager sharedManager] hideLoadingWithmessage:nil success:NO];
    }];
}

- (void)headerRereshing
{
    [self refreshData: 1];
}

- (void)footerRefreshing
{
    [self refreshData:self.page];
}

@end
