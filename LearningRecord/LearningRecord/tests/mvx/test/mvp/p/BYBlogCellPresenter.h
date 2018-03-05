//
//  BYBlogCellPresenter.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYBlog.h"
#import "BYUserAPIManager.h"

@class BYBlogCellPresenter;
@protocol BYBlogCellPresenterCallBack <NSObject>
@optional
- (void)blogPresenterDidUpdateLikeState:(BYBlogCellPresenter *)presenter;
- (void)blogPresenterDidUpdateShareState:(BYBlogCellPresenter *)presenter;
@end
@interface BYBlogCellPresenter : NSObject
@property (nonatomic, weak) id<BYBlogCellPresenterCallBack> view;
+ (instancetype)presenterWithBlog:(BYBlog *)blog;
- (BYBlog *)blog;
- (BOOL)isLiked;
- (NSString *)blogTitleText;
- (NSString *)blogSummaryText;
- (NSString *)blogLikeCountText;
- (NSString *)blogShareCountText;

- (void)likeBlogWithCompletionHandler:(NetworkCompletionHandler)completionHandler;
- (void)shareBlogWithCompletionHandler:(NetworkCompletionHandler)completionHandler;
@end
