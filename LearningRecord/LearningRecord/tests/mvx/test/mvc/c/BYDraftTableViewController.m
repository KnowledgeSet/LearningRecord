//
//  BYDraftTableViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYDraftTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "BYDraftCellHelper.h"
#import "BYDraftTableViewCell.h"

#define RowHeight 44
#define ReuseIdentifier @"BYDraftTableViewCell"

@interface BYDraftTableViewController ()
@property (nonatomic, copy) void(^didSelectedRowHandler)(BYDraft *);
@property (nonatomic, assign) NSUInteger    userId;
@property (nonatomic, strong) BYUserAPIManager  *apiManager;

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSMutableArray<BYDraftCellHelper *>    *drafts;
@end

@implementation BYDraftTableViewController
+ (instancetype)instanceWithUserId:(NSUInteger)userId {
    return [[BYDraftTableViewController new] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        self.userId = userId;
        self.drafts = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.apiManager = [BYUserAPIManager new];
        [self.tableView registerNib:[UINib nibWithNibName:ReuseIdentifier bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        __weak typeof(self) weakSelf = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.apiManager refreshUserDraftsWithUserId:userId completionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.mj_header endRefreshing];
                if (!error) {
                    [weakSelf.drafts removeAllObjects];
                    [weakSelf.tableView.mj_footer resetNoMoreData];
                    [weakSelf reloadTableViewWithDrafts:result];
                }
            }];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.apiManager loadMoreUserDraftsWithUserId:userId completionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.mj_footer endRefreshing];
                if (!error) {
                    [weakSelf reloadTableViewWithDrafts:result];
                }
                else if (error.code == NetworkErrorNoMoreData) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }];
        }];
    }
    return self;
}

- (void)fetchData {
    [self.apiManager refreshUserDraftsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        if (!error) {
            [self reloadTableViewWithDrafts:result];
        }
    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.drafts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYDraftCellHelper *cellHelper = self.drafts[indexPath.row];
    BYDraftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.title = cellHelper.draftTitleText;
    cell.summary = cellHelper.draftSummaryText;
    cell.editDate = cellHelper.draftEditDate;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    !self.didSelectedRowHandler ?: self.didSelectedRowHandler(self.drafts[indexPath.row].draft);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除这份草稿吗?" preferredStyle:(UIAlertControllerStyleAlert)];
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
        [self.tableView.viewController presentViewController:alert animated:YES completion:NULL];
    }
}

- (void)deleteDraft:(NSIndexPath *)indexPath {
    [[BYUserAPIManager new] deleteDraftWithDraftId:self.drafts[indexPath.row].draft.draftId completionHandler:^(NSError *error, id result) {
        if (error) {
            NSLog(@"%@", error.domain);
        }
        else {
            [self.drafts removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }
    }];
}

- (void)reloadTableViewWithDrafts:(NSArray *)drafts {
    for (BYDraft *draft in drafts) {
        [self.drafts addObject:[BYDraftCellHelper helperWithDraft:draft]];
    }
    [self.tableView reloadData];
}
@end
