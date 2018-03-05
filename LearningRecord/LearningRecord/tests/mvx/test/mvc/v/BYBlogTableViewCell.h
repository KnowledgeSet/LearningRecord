//
//  BYBlogTableViewCell.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYBlogTableViewCell : UITableViewCell
- (void)setTitle:(NSString *)title;
- (void)setSummary:(NSString *)summary;
- (void)setLikeState:(BOOL)isLiked;
- (void)setLikeCountText:(NSString *)likeCountText;
- (void)setShareCountText:(NSString *)shareCountText;

- (void)setDidLikeHandler:(void(^)(void))didLikeHandler;
@end
