//
//  BYCircleListSectionHeaderView.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYCircleListSectionHeaderView.h"
#import "BYCircleListSectionHeaderViewModel.h"

@interface BYCircleListSectionHeaderView ()
@property (nonatomic, strong) BYCircleListSectionHeaderViewModel    *viewModel;
@property (nonatomic, strong) UIImageView   *bgImageView;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIImageView   *lineImageView;
@end

@implementation BYCircleListSectionHeaderView

- (instancetype)initWithViewModel:(id<BYRACViewModelProtocol>)viewModel {
    self.viewModel = (BYCircleListSectionHeaderViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)by_setupViews {
    [self addSubview:self.bgImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineImageView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
}

- (void)updateConstraints {
    CGFloat padding = 10;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(20);
    }];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [super updateConstraints];
}

- (void)by_bindViewModel {
    // KVO   distinctUntilChanged 去重信号
    RAC(self.titleLabel, text) = [[RACObserve(self, viewModel.title) distinctUntilChanged] takeUntil:self.rac_willDeallocSignal];
}

#pragma mark - lazy load
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
    }
    return _bgImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineImageView;
}

@end
