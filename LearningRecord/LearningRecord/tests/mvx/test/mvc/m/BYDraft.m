//
//  BYDraft.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYDraft.h"

@implementation BYDraft
- (instancetype)initWithDraftId:(NSUInteger)draftId {
    
    self.draftId = draftId;
    self.draftTitle = [NSString stringWithFormat:@"draftTitle%ld", draftId];
    self.draftSummary = [NSString stringWithFormat:@"draftSummary%ld", draftId];
    self.editDate = [[NSDate date] timeIntervalSince1970] + arc4random() % 200;
    
    return self;
}
@end
