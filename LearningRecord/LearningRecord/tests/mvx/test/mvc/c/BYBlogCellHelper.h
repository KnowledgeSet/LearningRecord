//
//  BYBlogCellHelper.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYBlog.h"
@interface BYBlogCellHelper : NSObject
+ (instancetype)helperWithBlog:(BYBlog *)blog;

- (BYBlog *)blog;

- (BOOL)isLiked;
- (NSString *)blogTitleText;
- (NSString *)blogSummaryText;
- (NSString *)blogLikeCountText;
- (NSString *)blogShareCountText;
@end
