//
//  BYBlogCellHelper.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBlogCellHelper.h"

@interface BYBlogCellHelper ()
@property (nonatomic, strong) BYBlog    *blog;
@end

@implementation BYBlogCellHelper
+ (instancetype)helperWithBlog:(BYBlog *)blog {
    BYBlogCellHelper *helper = [BYBlogCellHelper new];
    helper.blog = blog;
    return helper;
}

- (BOOL)isLiked {
    return self.blog.isLiked;
}

- (NSString *)blogTitleText {
    return self.blog.blogTitle.length > 0 ? self.blog.blogTitle : @"未命名";
}

- (NSString *)blogSummaryText {
    return self.blog.blogSummary.length > 0 ? [NSString stringWithFormat:@"摘要: %@", self.blog.blogSummary] : @"这个人很懒, 什么也没有写...";
}

- (NSString *)blogLikeCountText {
    return [NSString stringWithFormat:@"赞 %ld", self.blog.likeCount];
}

- (NSString *)blogShareCountText {
    return [NSString stringWithFormat:@"分享 %ld", self.blog.shareCount];
}
@end
