//
//  BYDraftViewControllerPresenter.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYDraftViewControllerPresenter.h"

@interface BYDraftViewControllerPresenter ()
@property (nonatomic, assign) NSUInteger    userId;
@property (nonatomic, strong) BYUserAPIManager  *apiManager;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSMutableArray<BYDraftCellPresenter *> *drafts;
@end

@implementation BYDraftViewControllerPresenter
+ (instancetype)presenterWithUserId:(NSUInteger)userId {
    return [[BYDraftViewControllerPresenter alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        self.userId = userId;
        self.drafts = [NSMutableArray array];
        self.apiManager = [BYUserAPIManager new];
    }
    return self;
}

- (NSArray *)allDatas {
    return self.drafts;
}

- (void)refreshDataWithCompletionHandler:(NetworkCompletionHandler)handler {
    [self.apiManager refreshUserDraftsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        if (!error) {
            [self.drafts removeAllObjects];
            [self formatResult:result];
        }
        else {
            // 如果API层面没有格式化好错误 那么在P层格式化错误
        }
        !handler ?: handler(error, result);
    }];
}

- (void)loadMoreDataWithCompletionHandler:(NetworkCompletionHandler)handler {
    [self.apiManager loadMoreUserDraftsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        if (!error) {
            [self formatResult:result];
        }
        else {
            
        }
        !handler ?: handler(error, result);
    }];
}

- (void)deleteDraftAtIndex:(NSUInteger)index completionHandler:(NetworkCompletionHandler)handler {
    if (index >= self.drafts.count) {
        !handler ?: handler([NSError new], nil);
    }
    else {
        [self.drafts[index] deleteDraft:^(NSError *error, id result) {
            error ?: [self.drafts removeObjectAtIndex:index];
            !handler ?: handler(error, result);
        }];
    }
}

- (void)formatResult:(NSArray *)result {
    for (BYDraft *draft in result) {
        [self.drafts addObject:[BYDraftCellPresenter presenterWithDraft:draft]];
    }
}
@end
