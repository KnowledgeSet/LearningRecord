//
//  BYDraftCellHelper.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYDraftCellHelper.h"

@interface BYDraftCellHelper ()
@property (nonatomic, strong) BYDraft   *draft;
@end

@implementation BYDraftCellHelper
+ (instancetype)helperWithDraft:(BYDraft *)draft {
    BYDraftCellHelper *helper = [BYDraftCellHelper new];
    helper.draft = draft;
    return helper;
}

- (NSString *)draftEditDate {
    
    NSUInteger date = self.draft.editDate > 0 ? self.draft.editDate : [[NSDate date] timeIntervalSince1970];
    return [[NSDate dateWithTimeIntervalSince1970:date] description];
}

- (NSString *)draftTitleText {
    return self.draft.draftTitle.length > 0 ? self.draft.draftTitle : @"未命名";
}

- (NSString *)draftSummaryText {
    return self.draft.draftSummary.length > 0 ? [NSString stringWithFormat:@"摘要: %@", self.draft.draftSummary] : @"写点什么吧~";
}
@end
