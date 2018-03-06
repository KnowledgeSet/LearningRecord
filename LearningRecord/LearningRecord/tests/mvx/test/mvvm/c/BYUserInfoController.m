//
//  BYUserInfoController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYUserInfoController.h"

@interface BYUserInfoController ()
//@property (nonatomic, strong) BYUserInfoView    *view;
//@property (nonatomic, strong) BYUserInfoViewModel   *viewModel;

@property (nonatomic, strong) UIView<BYUserInfoViewProtocol> *view;
@property (nonatomic, strong) id<BYUserInfoViewModelProtocol> viewModel;

@property (nonatomic, strong) RACCommand *onClickIconCommand;
@end

@implementation BYUserInfoController
+ (instancetype)instanceWithView:(UIView<BYUserInfoViewProtocol> *)view viewModel:(id<BYUserInfoViewModelProtocol>)viewModel {
    if (view == nil || viewModel == nil) { return nil; }
    return [[BYUserInfoController alloc] initWith:view viewModel:viewModel];
}

- (instancetype)initWith:(UIView<BYUserInfoViewProtocol> *)view viewModel:(id<BYUserInfoViewModelProtocol>)viewModel {
    if (self = [super init]) {
        self.view = view;
        self.viewModel = viewModel;
        [self bind];
    }
    return self;
}

- (void)bind {
    RAC(self.view.nameLabel, text) = RACObserve(self, viewModel.name);
    RAC(self.view.summaryLabel, text) = RACObserve(self, viewModel.summary);
    RAC(self.view.blogCountLabel, text) = RACObserve(self, viewModel.blogCount);
    RAC(self.view.friendCountLabel, text) = RACObserve(self, viewModel.friendCount);
    @weakify(self);
    [RACObserve(self, viewModel.icon) subscribeNext:^(UIImage *  _Nullable icon) {
        @strongify(self);
        [self.view.iconButton setBackgroundImage:icon forState:UIControlStateNormal];
    }];
    [[self.view.iconButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.onClickIconCommand execute:self.viewModel.user];
    }];
}

- (void)fetchData {
    [[[self.viewModel fetchUserInfoCommand] execute:nil] subscribeError:^(NSError * _Nullable error) {
        // show error view
    } completed:^{
       // do completed
    }];
}
@end
