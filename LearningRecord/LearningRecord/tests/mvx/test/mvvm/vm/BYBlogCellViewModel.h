//
//  BYBlogCellViewModel.h
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYMVXHeader.h"
#import "BYUserAPIManager.h"
#import "BYBlog.h"

extern NSString *LikeBlogEvent;
extern NSString *kCellViewModel;
@interface BYBlogCellViewModel : NSObject
+ (instancetype)viewModelWithBlog:(BYBlog *)blog;
- (BYBlog *)blog;
- (BOOL)isLiked;
- (NSString *)blogTitleText;
- (NSString *)blogLikeCount;
- (NSString *)blogSummaryText;
- (NSString *)blogShareCount;

- (RACCommand *)likeBlogCommand;
- (RACCommand *)shareBlogCommand;
@end
