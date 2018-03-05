//
//  BYMVPBlogTableViewCell.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYMVPBlogTableViewCell.h"

@interface BYMVPBlogTableViewCell ()<BYBlogCellPresenterCallBack>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (nonatomic, copy) void(^didLikeHandler)(void);
@end

@implementation BYMVPBlogTableViewCell

- (void)blogPresenterDidUpdateLikeState:(BYBlogCellPresenter *)presenter {
    [self.likeButton setTitle:presenter.blogLikeCountText forState:UIControlStateNormal];
    [self.likeButton setTitleColor:presenter.isLiked ? [UIColor redColor] : [UIColor blackColor] forState:UIControlStateNormal];
}

- (void)blogPresenterDidUpdateShareState:(BYBlogCellPresenter *)presenter {
    [self.shareButton setTitle:presenter.blogShareCountText forState:UIControlStateNormal];
}

- (IBAction)onClickLikeButton:(UIButton *)sender {
    !self.didLikeHandler ?: self.didLikeHandler();
}

- (void)setPresenter:(BYBlogCellPresenter *)presenter {
    _presenter = presenter;
    
    presenter.view = self;
    self.titleLabel.text = presenter.blogTitleText;
    self.summaryLabel.text = presenter.blogSummaryText;
    self.likeButton.selected = presenter.isLiked;
    [self.likeButton setTitle:presenter.blogLikeCountText forState:UIControlStateNormal];
    [self.shareButton setTitle:presenter.blogShareCountText forState:UIControlStateNormal];
}

@end
