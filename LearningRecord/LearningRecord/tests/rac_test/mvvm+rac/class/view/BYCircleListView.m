//
//  BYCircleListView.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYCircleListView.h"
#import "BYCircleListViewModel.h"
#import "BYCircleListHeaderView.h"
#import "BYCircleListSectionHeaderView.h"
#import "BYCircleListTableViewCell.h"

@interface BYCircleListView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView   *mainTableView;
@property (nonatomic, strong) BYCircleListViewModel *viewModel;
@property (nonatomic, strong) BYCircleListHeaderView    *headerView;
@property (nonatomic, strong) BYCircleListSectionHeaderView *sectionHeaderView;
@end

@implementation BYCircleListView

- (instancetype)initWithViewModel:(id<BYRACViewModelProtocol>)viewModel {
    self.viewModel = (BYCircleListViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints {
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

#pragma mark - private
- (void)by_setupViews {
    [self addSubview:self.mainTableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)by_bindViewModel {
    [self.viewModel.refreshDataCommand execute:nil];
    @weakify(self);
    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.mainTableView reloadData];
    }];
    [self.viewModel.refreshEndSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.mainTableView reloadData];
        switch ([x integerValue]) {
            case BYRACRefreshStatusHeaderMore:
                {
                    [self.mainTableView.mj_header endRefreshing];
                    if (self.mainTableView.mj_footer == nil) {
                        self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                            @strongify(self);
                            [self.viewModel.nextPageCommand execute:nil];
                        }];
                    }
                }
                break;
            case BYRACRefreshStatusHeaderNoMore:
            {
                [self.mainTableView.mj_header endRefreshing];
                self.mainTableView.mj_footer = nil;
                break;
            }
            case BYRACRefreshStatusFooterMore:
            {
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer resetNoMoreData];
                [self.mainTableView.mj_footer endRefreshing];
                break;
            }
            case BYRACRefreshStatusFooterNoMore:
            {
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                break;
            }
            case BYRACRefreshStatusError:
            {
                [self.mainTableView.mj_footer endRefreshing];
                [self.mainTableView.mj_header endRefreshing];
                break;
            }
            default:
                break;
        }
    }];
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.cellClickSubject sendNext:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYCircleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BYCircleListTableViewCell class])];
    if (self.viewModel.dataArray.count > indexPath.row) {
        cell.viewModel = self.viewModel.dataArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

#pragma mark - lazy load
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.tableHeaderView = self.headerView;
        [_mainTableView registerClass:[BYCircleListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BYCircleListTableViewCell class])];
        
        @weakify(self);
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.refreshDataCommand execute:nil];
        }];
        _mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.nextPageCommand execute:nil];
        }];
    }
    return _mainTableView;
}

- (BYCircleListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BYCircleListViewModel alloc] init];
    }
    return _viewModel;
}

- (BYCircleListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BYCircleListHeaderView alloc] initWithViewModel:self.viewModel.headerViewModel];
        _headerView.frame = CGRectMake(0, 0, BYSCREEN_WIDTH, 160);
    }
    return _headerView;
}

- (BYCircleListSectionHeaderView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[BYCircleListSectionHeaderView alloc] initWithViewModel:self.viewModel.sectionHeaderViewModel];
    }
    return _sectionHeaderView;
}


@end
