//
//  BYBlogViewPresenter.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBlogViewPresenter.h"

@interface BYBlogViewPresenter ()
@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) BYUserAPIManager  *apiManager;
@property (nonatomic, strong) NSMutableArray<BYBlogCellPresenter *> *blogs;
@end

@implementation BYBlogViewPresenter
+ (instancetype)presenterWithUserId:(NSUInteger)userId {
    return [[BYBlogViewPresenter alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        self.blogs = [NSMutableArray array];
        self.userId = userId;
        self.apiManager = [BYUserAPIManager new];
    }
    return self;
}

- (NSArray *)allDatas {
    return self.blogs;
}

- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHandler {
    [self.apiManager refreshUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        if (!error) {
            [self.blogs removeAllObjects];
            [self formatResult:result];
        }
        if ([self.view respondsToSelector:@selector(blogViewPresenter:didRefreshDataWithResult:error:)]) {
            [self.view blogViewPresenter:self didRefreshDataWithResult:result error:error];
        }
        !completionHandler ?: completionHandler(error, result);
    }];
}

- (void)refreshData {
    [self fetchDataWithCompletionHandler:nil];
}

- (void)loadMoreData {
    [self.apiManager loadMoreUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        error ?: [self formatResult:result];
        if ([self.view respondsToSelector:@selector(blogViewPresenter:didLoadMoreDataWithResult:error:)] ) {
            [self.view blogViewPresenter:self didLoadMoreDataWithResult:result error:error];
        }
    }];
}

- (void)formatResult:(NSArray *)result {
    for (BYBlog *blog in result) {
        [self.blogs addObject:[BYBlogCellPresenter presenterWithBlog:blog]];
    }
}
@end
