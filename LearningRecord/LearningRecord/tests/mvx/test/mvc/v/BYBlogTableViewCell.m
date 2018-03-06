//
//  BYBlogTableViewCell.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBlogTableViewCell.h"

@interface BYBlogTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (nonatomic, copy) void(^didLikeHandler)(void);
@end

@implementation BYBlogTableViewCell
- (IBAction)onClickLikeButton:(UIButton *)sender {
    !self.didLikeHandler ?: self.didLikeHandler();
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSummary:(NSString *)summary {
    self.summaryLabel.text = summary;
}

- (void)setLikeState:(BOOL)isLiked {
    [self.likeButton setTitleColor:isLiked ? [UIColor redColor] : [UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setLikeCountText:(NSString *)likeCountText {
    [self.likeButton setTitle:likeCountText forState:UIControlStateNormal];
}

- (void)setShareCountText:(NSString *)shareCountText {
    [self.shareButton setTitle:shareCountText forState:UIControlStateNormal];
}

@end
