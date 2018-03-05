//
//  BYBlog.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBlog.h"

@implementation BYBlog
- (instancetype)initWithBlogId:(NSUInteger)blogId {
    
    self.blogId = blogId;
    self.isLiked = blogId % 2;
    self.likeCount = blogId + 10;
    self.blogTitle = [NSString stringWithFormat:@"blogTitle%ld", blogId];
    self.shareCount = blogId + 8;
    self.blogSummary = [NSString stringWithFormat:@"blogSummary%ld", blogId];
    
    return self;
}
@end
