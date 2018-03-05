//
//  BYBlogView.m
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBlogView.h"
#import <MJRefresh/MJRefresh.h>
#import "BYBlogCell.h"


#define RowHeight 44
#define ReuseIdentifier @"BYBlogCell"

@interface BYBlogView ()
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) BYBlogViewModel   *viewModel;

@property (nonatomic, strong) RACCommand    *fetchDataCommand;
@property (nonatomic, strong) RACCommand    *didSelectedRowCommand;
@end

@implementation BYBlogView
+ (instancetype)instanceWithViewModel:(BYBlogViewModel *)viewModel {
    return [[BYBlogView alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(BYBlogViewModel *)viewModel {
    if (self = [super init]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.viewModel = viewModel;
        
        @weakify(self);
        self.fetchDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            RACSubject *subject = [RACSubject subject];
            [self.viewModel.refreshDataSignal subscribeError:^(NSError * _Nullable error) {
                [subject sendError:error];
            } completed:^{
                [self.tableView reloadData];
                [subject sendCompleted];
            }];
            return subject;
        }];
        
        [self.tableView registerNib:[UINib nibWithNibName:ReuseIdentifier bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.refreshDataSignal subscribeError:^(NSError * _Nullable error) {
                [self.tableView.mj_header endRefreshing];
            } completed:^{
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
            }];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.loadMoreDataSignal subscribeError:^(NSError * _Nullable error) {
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } completed:^{
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
            }];
        }];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.allDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYBlogCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.viewModel = self.viewModel.allDatas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.didSelectedRowCommand execute:self.viewModel.allDatas[indexPath.row].blog];
}
@end
