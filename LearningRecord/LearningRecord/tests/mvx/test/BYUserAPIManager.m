//
//  BYUserAPIManager.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYUserAPIManager.h"
#import "BYUser.h"
#import "BYBlog.h"
#import "BYDraft.h"

#define PageSize 20

@interface BYUserAPIManager ()
@property (nonatomic, assign) NSUInteger    blogPage;
@property (nonatomic, assign) NSUInteger    draftPage;
@end
@implementation BYUserAPIManager
- (void)fetchUserInfoWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !completionHandler ?: completionHandler(nil, [[BYUser alloc] initWithUserId:userId]);
    });
}

- (void)refreshUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    self.blogPage = 0;
    [self fetchUserBlogsWithUserId:userId page:self.blogPage pageSize:PageSize completionHandler:completionHandler];
}

- (void)loadMoreUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    self.blogPage += 1;
    [self fetchUserBlogsWithUserId:userId page:self.blogPage pageSize:PageSize completionHandler:completionHandler];
}

- (void)fetchUserBlogsWithUserId:(NSUInteger)userId page:(NSUInteger)page pageSize:(NSUInteger)pageSize completionHandler:(NetworkCompletionHandler)completionHandler {
    NSUInteger delayTime = page == 0 ? 1.5 : 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (page >= 2) {
            !completionHandler ?: completionHandler([NSError errorWithDomain:@"没有更多了" code:NetworkErrorNoMoreData userInfo:nil], nil);
        } else {
            
            NSMutableArray *blogs = [NSMutableArray array];
            for (int i = 0; i < pageSize; i ++) {
                [blogs addObject:[[BYBlog alloc] initWithBlogId:pageSize * page + i]];
            }
            !completionHandler ?: completionHandler(nil, blogs);
        }
    });
}

- (void)refreshUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    self.draftPage = 0;
    [self fetchUserDraftsWithUserId:userId page:self.draftPage pageSize:PageSize completionHandler:completionHandler];
}

- (void)loadMoreUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    self.draftPage += 1;
    [self fetchUserDraftsWithUserId:userId page:self.draftPage pageSize:PageSize completionHandler:completionHandler];
}

- (void)fetchUserDraftsWithUserId:(NSUInteger)userId page:(NSUInteger)page pageSize:(NSUInteger)pageSize completionHandler:(NetworkCompletionHandler)completionHandler {
    NSUInteger delayTime = page == 0 ? 1.5 : 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (page >= 1) {
            !completionHandler ?: completionHandler([NSError errorWithDomain:@"没有更多了"
                                                                        code:NetworkErrorNoMoreData userInfo:nil], nil);
        }
        else {
            NSMutableArray *drafts = [NSMutableArray array];
            for (NSInteger i = 0; i < PageSize; i ++) {
                [drafts addObject:[[BYDraft alloc] initWithDraftId:pageSize * page + i]];
            }
            !completionHandler ?: completionHandler(nil, drafts);
        }
    });
}

- (void)likeBlogWithBlogId:(NSUInteger)blogId completionHandler:(NetworkCompletionHandler)complectionHandler {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSError *error = arc4random() % 2 ? [NSError errorWithDomain:@"点赞失败" code:123 userInfo:nil] : nil;
        !complectionHandler ?: complectionHandler(error, nil);
    });
}

- (void)deleteDraftWithDraftId:(NSUInteger)draftId completionHandler:(NetworkCompletionHandler)completionHandler {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSError *error = draftId % 2 == 0 ? [NSError errorWithDomain:@"服务器繁忙, 请稍后再试~" code:123 userInfo:nil] : nil;
        !completionHandler ?: completionHandler(error, nil);
    });
}
@end
