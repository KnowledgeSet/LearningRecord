//
//  BYBlogViewModel.h
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYBlogCellViewModel.h"
@interface BYBlogViewModel : NSObject
+ (instancetype)viewModelWithUserId:(NSUInteger)userId;
- (NSArray<BYBlogCellViewModel *> *)allDatas;
- (RACSignal *)refreshDataSignal;
- (RACSignal *)loadMoreDataSignal;
@end
