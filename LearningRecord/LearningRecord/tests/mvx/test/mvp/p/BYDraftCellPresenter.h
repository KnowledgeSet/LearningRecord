//
//  BYDraftCellPresenter.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYDraft.h"
#import "BYUserAPIManager.h"
@interface BYDraftCellPresenter : NSObject
+ (instancetype)presenterWithDraft:(BYDraft *)draft;
- (BYDraft *)draft;
- (NSString *)draftTitleText;
- (NSString *)draftSummaryText;
- (NSString *)draftEditDateText;

- (void)deleteDraft:(NetworkCompletionHandler)handler;
@end
