//
//  BYDraft.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYDraft : NSObject
- (instancetype)initWithDraftId:(NSUInteger)draftId;

@property (copy, nonatomic) NSString *draftTitle;
@property (copy, nonatomic) NSString *draftSummary;
@property (assign, nonatomic) NSUInteger draftId;
@property (assign, nonatomic) NSUInteger editDate;
@end
