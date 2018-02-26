//
//  BYCircleListCollectionViewCell.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYCircleListCollectionViewCell.h"

@interface BYCircleListCollectionViewCell ()
@property (nonatomic, strong) UIImageView   *headerImageView;
@property (nonatomic, strong) UILabel   *nameLabel;
@end

@implementation BYCircleListCollectionViewCell
- (void)by_setupViews {
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLabel];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    CGFloat padding = 10;
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(80);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_bottom).offset(padding);
        make.height.mas_equalTo(15);
        make.left.right.equalTo(self.headerImageView);
    }];
    [super updateConstraints];
}

- (void)setViewModel:(BYCircleListCollectionViewCellViewModel *)viewModel {
    if (!viewModel) {
        return;
    }
    _viewModel = viewModel;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.headerImageStr] placeholderImage:[UIImage imageNamed:@"120.jpeg"]];
    self.nameLabel.text = viewModel.name;
}

- (void)setType:(NSString *)type {
    self.headerImageView.image = [UIImage imageNamed:@"121.jpeg"];
    self.nameLabel.text = @"加入新圈子";
}

#pragma mark - lazy load
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
    }
    return _headerImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _nameLabel;
}
@end
