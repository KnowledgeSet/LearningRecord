//
//  BYBlogViewModel.m
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBlogViewModel.h"

@interface BYBlogViewModel ()
@property (nonatomic, assign) NSUInteger    userId;
@property (nonatomic, strong) BYUserAPIManager  *apiManager;
@property (nonatomic, strong) NSMutableArray<BYBlogCellViewModel *> *blogs;

@property (nonatomic, strong) RACSignal *refreshDataSignal;
@property (nonatomic, strong) RACSignal *loadMoreDataSignal;
@end

@implementation BYBlogViewModel
+ (instancetype)viewModelWithUserId:(NSUInteger)userId {
    return [[BYBlogViewModel alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        self.blogs = [NSMutableArray array];
        self.userId = userId;
        self.apiManager = [BYUserAPIManager new];
        
        @weakify(self);
        self.refreshDataSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            [self.apiManager refreshUserBlogsWithUserId:userId completionHandler:^(NSError *error, id result) {
                if (!error) {
                    [self.blogs removeAllObjects];
                    [self formatResult:result];
                }
                error ? [subscriber sendError:error] : [subscriber sendCompleted];
            }];
            return nil;
        }];
        self.loadMoreDataSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            [self.apiManager loadMoreUserBlogsWithUserId:userId completionHandler:^(NSError *error, id result) {
                error ?: [self formatResult:result];
                error ? [subscriber sendError:error] : [subscriber sendCompleted];
            }];
            return nil;
        }];
    }
    return self;
}

- (NSArray *)allDatas {
    return self.blogs;
}

- (void)formatResult:(NSArray *)result {
    for (BYBlog *blog in result) {
        [self.blogs addObject:[BYBlogCellViewModel viewModelWithBlog:blog]];
    }
}
@end
