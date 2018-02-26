//
//  BYCircleListTableViewCell.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYCircleListTableViewCell.h"

@interface BYCircleListTableViewCell ()
@property (nonatomic, strong) UIImageView   *headerImageView;
@property (nonatomic, strong) UILabel   *nameLabel;
@property (nonatomic, strong) UIImageView   *articleImageView;
@property (nonatomic, strong) UILabel   *articleLabel;
@property (nonatomic, strong) UIImageView   *peopleImageView;
@property (nonatomic, strong) UILabel   *peopleNumLabel;
@property (nonatomic, strong) UILabel   *contentLabel;
@property (nonatomic, strong) UIImageView   *lineImageView;
@end

@implementation BYCircleListTableViewCell

- (void)setViewModel:(BYCircleListCollectionViewCellViewModel *)viewModel {
    if (!viewModel) {
        return;
    }
    _viewModel = viewModel;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.headerImageStr] placeholderImage:[UIImage imageNamed:@"122.jpeg"]];
    self.nameLabel.text = viewModel.name;
    self.articleLabel.text = viewModel.articleNum;
    self.peopleNumLabel.text = viewModel.peopleNum;
    self.contentLabel.text = viewModel.content;
}

- (void)by_setupViews {
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.articleImageView];
    [self.contentView addSubview:self.articleLabel];
    [self.contentView addSubview:self.peopleImageView];
    [self.contentView addSubview:self.peopleNumLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.lineImageView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    CGFloat padding = 10;
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(padding);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(padding);
        make.top.equalTo(self.headerImageView);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(15);
    }];
    [self.articleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(padding);
    }];
    [self.articleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.articleImageView.mas_right).offset(3);
        make.size.mas_equalTo(CGSizeMake(50, 15));
        make.centerY.equalTo(self.articleImageView);
    }];
    [self.peopleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.articleLabel.mas_right).offset(padding);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(self.articleImageView);
    }];
    [self.peopleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.peopleImageView.mas_right).offset(3);
        make.centerY.equalTo(self.peopleImageView);
        make.size.mas_equalTo(CGSizeMake(50, 15));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.articleImageView.mas_bottom).offset(padding);
        make.left.equalTo(self.articleImageView);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(15);
    }];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    [super updateConstraints];
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
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (UIImageView *)articleImageView {
    if (!_articleImageView) {
        _articleImageView = [[UIImageView alloc] init];
        _articleImageView.backgroundColor = [UIColor redColor];
    }
    return _articleImageView;
}

- (UILabel *)articleLabel {
    if (!_articleLabel) {
        _articleLabel = [UILabel new];
        _articleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _articleLabel;
}

- (UIImageView *)peopleImageView {
    if (!_peopleImageView) {
        _peopleImageView = [UIImageView new];
        _peopleImageView.backgroundColor = [UIColor redColor];
    }
    return _peopleImageView;
}

- (UILabel *)peopleNumLabel {
    if (!_peopleNumLabel) {
        _peopleNumLabel = [UILabel new];
        _peopleNumLabel.font = [UIFont systemFontOfSize:12];
    }
    return _peopleNumLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineImageView;
}

@end
