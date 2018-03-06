//
//  BYUserAPIManager.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYMVXHeader.h"


@interface BYUserAPIManager : NSObject
- (void)fetchUserInfoWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
- (void)refreshUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
- (void)loadMoreUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
- (void)refreshUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
- (void)loadMoreUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
- (void)likeBlogWithBlogId:(NSUInteger)blogId completionHandler:(NetworkCompletionHandler)complectionHandler;
- (void)deleteDraftWithDraftId:(NSUInteger)draftId completionHandler:(NetworkCompletionHandler)completionHandler;
@end
