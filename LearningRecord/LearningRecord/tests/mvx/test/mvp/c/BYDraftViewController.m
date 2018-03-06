//
//  BYDraftViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYDraftViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "BYMVPDraftTableViewCell.h"

#define RowHeight 44
#define ReuseIdentifier @"BYMVPDraftTableViewCell"

@interface BYDraftViewController ()
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) BYDraftViewControllerPresenter    *presenter;
@property (nonatomic, copy) void(^didSelectedRowHandler)(BYDraft *draft);
@end

@implementation BYDraftViewController
+ (instancetype)instanceWithPresenter:(BYDraftViewControllerPresenter *)presenter {
    return [[BYDraftViewController alloc] initWithPresenter:presenter];
}

- (instancetype)initWithPresenter:(BYDraftViewControllerPresenter *)presenter {
    if (self = [super init]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.presenter = presenter;
        [self.tableView registerNib:[UINib nibWithNibName:ReuseIdentifier bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        
        __weak typeof(self) weakSelf = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.presenter refreshDataWithCompletionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.mj_header endRefreshing];
                if (!error) {
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_footer resetNoMoreData];
                }
            }];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.presenter loadMoreDataWithCompletionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.mj_footer endRefreshing];
                if (!error) {
                    [weakSelf.tableView reloadData];
                }
                else if (error.code == NetworkErrorNoMoreData) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }];
        }];
    }
    return self;
}

- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)handler {
    [self.presenter refreshDataWithCompletionHandler:^(NSError *error, id result) {
        if (!error) {
            [self.tableView reloadData];
        }
        !handler ?: handler(error, result);
    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.allDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"确定删除这份草稿?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         [self deleteDraft:indexPath];
                                                     }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
        [alert addAction:sure];
        [alert addAction:cancel];
        [self.tableView.navigationController presentViewController:alert animated:YES completion:NULL];
    }
}

- (void)deleteDraft:(NSIndexPath *)indexPath {
    [self.presenter deleteDraftAtIndex:indexPath.row completionHandler:^(NSError *error, id result) {
        error ? NSLog(@"%@", error.domain) : [self.tableView reloadData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYMVPDraftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.presenter = self.presenter.allDatas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    !self.didSelectedRowHandler ?: self.didSelectedRowHandler(self.presenter.allDatas[indexPath.row].draft);
}
@end
