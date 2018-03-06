//
//  BYBlogViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBlogViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "BYMVPBlogTableViewCell.h"

#define RowHeight 44
#define ReuseIdentifier @"BYMVPBlogTableViewCell"

@interface BYBlogViewController ()<BYBlogViewPresenterCallBack>
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) BYBlogViewPresenter   *presenter;
@end

@implementation BYBlogViewController
+ (instancetype)instancetypeWithPresenter:(BYBlogViewPresenter *)presenter {
    return [[BYBlogViewController alloc] initWithPresenter:presenter];
}
- (instancetype)initWithPresenter:(BYBlogViewPresenter *)presenter {
    if (self = [super init]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerNib:[UINib nibWithNibName:ReuseIdentifier bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        
        self.presenter = presenter;
        self.presenter.view = self;//将V和P进行绑定(这里因为V是系统的TableView 无法简单的声明一个view属性 所以就绑定到TableView的持有者上面)
        
        __weak typeof(self) weakSelf = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.presenter refreshData];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.presenter loadMoreData];
        }];
    }
    return self;
}

- (void)blogViewPresenter:(BYBlogViewPresenter *)presenter didRefreshDataWithResult:(id)result error:(NSError *)error {
    [self.tableView.mj_header endRefreshing];
    if (!error) {
        [self.tableView reloadData];
        [self.tableView.mj_footer resetNoMoreData];
    }
    else if (self.presenter.allDatas.count == 0) {
        // show error view
    }
}

- (void)blogViewPresenter:(BYBlogViewPresenter *)presenter didLoadMoreDataWithResult:(id)result error:(NSError *)error {
    [self.tableView.mj_footer endRefreshing];
    if (!error) {
        [self.tableView reloadData];
    }
    else if (error.code == NetworkErrorNoMoreData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.allDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYMVPBlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.presenter = self.presenter.allDatas[indexPath.row];//PV绑定
    
    __weak typeof(cell) weakCell = cell;
    [cell setDidLikeHandler:^{//这里用一个handler是因为点赞失败需要弹框提示, 这个弹框是什么样式或者弹不弹框cell是不知道, 所以把事件传出来在C层处理, 或者你也可以再传到Scene层处理, 这个看具体的业务场景.
        
        //实际的点赞逻辑调用的还是P层实现
        [weakCell.presenter likeBlogWithCompletionHandler:^(NSError *error, id result) {
            !error ?: NSLog(@"%@", error.domain);
        }];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(blogViewControllerDidSelectBlog:)]) {
        [self.delegate blogViewControllerDidSelectBlog:self.presenter.allDatas[indexPath.row].blog];
    }
}
@end
