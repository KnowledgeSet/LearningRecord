//
//  BYBlog.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYBlog : NSObject
- (instancetype)initWithBlogId:(NSUInteger)blogId;

@property (copy, nonatomic) NSString *blogTitle;
@property (copy, nonatomic) NSString *blogSummary;
@property (assign, nonatomic) BOOL isLiked;
@property (assign, nonatomic) NSUInteger blogId;
@property (assign, nonatomic) NSUInteger likeCount;
@property (assign, nonatomic) NSUInteger shareCount;
@end
