//
//  BYRACCircleListViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACCircleListViewController.h"
#import "BYCircleListViewModel.h"
#import "BYCircleListView.h"

@interface BYRACCircleListViewController ()
@property (nonatomic, strong) BYCircleListView  *mainView;
@property (nonatomic, strong) BYCircleListViewModel *viewModel;
@end

@implementation BYRACCircleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

#pragma mark - private
- (void)by_addSubviews {
    [self.view addSubview:self.mainView];
}

- (void)by_bindViewModel {
    @weakify(self);
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        BYRACBaseViewController *vc = [[BYRACBaseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)by_layoutNavigation {
    self.title = @"圈子列表";
}

#pragma mark - lazy load
- (BYCircleListView *)mainView {
    if (!_mainView) {
        _mainView = [[BYCircleListView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (BYCircleListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BYCircleListViewModel alloc] init];
    }
    return _viewModel;
}

@end
