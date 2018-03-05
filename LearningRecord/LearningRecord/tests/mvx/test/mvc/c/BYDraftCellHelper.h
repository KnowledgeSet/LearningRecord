//
//  BYDraftCellHelper.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYDraft.h"
@interface BYDraftCellHelper : NSObject
+ (instancetype)helperWithDraft:(BYDraft *)draft;
- (BYDraft *)draft;
- (NSString *)draftEditDate;
- (NSString *)draftTitleText;
- (NSString *)draftSummaryText;
@end
