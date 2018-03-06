//
//  BYDraftCellPresenter.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYDraftCellPresenter.h"

@interface BYDraftCellPresenter ()
@property (nonatomic, strong) BYDraft *draft;
@end

@implementation BYDraftCellPresenter
+ (instancetype)presenterWithDraft:(BYDraft *)draft {
    BYDraftCellPresenter *presenter = [BYDraftCellPresenter new];
    presenter.draft = draft;
    return presenter;
}

- (void)deleteDraft:(NetworkCompletionHandler)handler {
    [[BYUserAPIManager new] deleteDraftWithDraftId:self.draft.draftId completionHandler:handler];
}

- (NSString *)draftTitleText {
    return self.draft.draftTitle.length > 0 ? self.draft.draftTitle : @"未命名";
}

- (NSString *)draftEditDateText {
    NSUInteger date = self.draft.editDate > 0 ? self.draft.editDate : [[NSDate date] timeIntervalSince1970];
    return [[NSDate dateWithTimeIntervalSince1970:date] description];
}

- (NSString *)draftSummaryText {
    return self.draft.draftSummary.length > 0 ? [NSString stringWithFormat:@"摘要: %@", self.draft.draftSummary] : @"写点什么吧~";
}
@end
