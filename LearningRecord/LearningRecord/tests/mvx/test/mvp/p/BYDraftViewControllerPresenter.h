//
//  BYDraftViewControllerPresenter.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYDraftCellPresenter.h"

@interface BYDraftViewControllerPresenter : NSObject
+ (instancetype)presenterWithUserId:(NSUInteger)userId;
- (NSArray<BYDraftCellPresenter *> *)allDatas;

- (void)refreshDataWithCompletionHandler:(NetworkCompletionHandler)handler;
- (void)loadMoreDataWithCompletionHandler:(NetworkCompletionHandler)handler;
- (void)deleteDraftAtIndex:(NSUInteger)index completionHandler:(NetworkCompletionHandler)handler;
@end
