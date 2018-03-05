//
//  BYBlogCell.m
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBlogCell.h"

@interface BYBlogCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@end

@implementation BYBlogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    @weakify(self);
    RAC(self.titleLabel, text) = RACObserve(self, viewModel.blogTitleText);
    RAC(self.summaryLabel, text) = RACObserve(self, viewModel.blogSummaryText);
    RAC(self.likeButton, selected) = [RACObserve(self, viewModel.isLiked) ignore:nil];
    [RACObserve(self, viewModel.blogLikeCount) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.likeButton setTitle:x forState:UIControlStateNormal];
    }];
    [RACObserve(self, viewModel.blogShareCount) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.shareButton setTitle:x forState:UIControlStateNormal];
    }];
}

- (IBAction)onClickLikeButton:(UIButton *)sender {
    [self routerEvent:LikeBlogEvent userInfo:@{kCellViewModel : self.viewModel}];
}

@end
