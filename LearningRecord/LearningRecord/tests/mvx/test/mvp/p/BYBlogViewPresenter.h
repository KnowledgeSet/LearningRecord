//
//  BYBlogViewPresenter.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYBlogCellPresenter.h"

@class BYBlogViewPresenter;
@protocol BYBlogViewPresenterCallBack<NSObject>
@optional
- (void)blogViewPresenter:(BYBlogViewPresenter *)presenter didRefreshDataWithResult:(id)result error:(NSError *)error;
- (void)blogViewPresenter:(BYBlogViewPresenter *)presenter didLoadMoreDataWithResult:(id)result error:(NSError *)error;
@end

@interface BYBlogViewPresenter : NSObject
@property (nonatomic, weak) id<BYBlogViewPresenterCallBack> view;
+ (instancetype)presenterWithUserId:(NSUInteger)userId;
- (NSArray<BYBlogCellPresenter *> *)allDatas;
- (void)refreshData;
- (void)loadMoreData;
- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHandler;
@end
