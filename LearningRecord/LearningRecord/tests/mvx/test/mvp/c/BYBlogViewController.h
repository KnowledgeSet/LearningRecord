//
//  BYBlogViewController.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYBlogViewPresenter.h"

@protocol BYBlogViewControllerCallBack <NSObject>
@optional
- (void)blogViewControllerDidSelectBlog:(BYBlog *)blog;
@end
@interface BYBlogViewController : NSObject<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) id<BYBlogViewControllerCallBack> delegate;
+ (instancetype)instancetypeWithPresenter:(BYBlogViewPresenter *)presenter;
- (UITableView *)tableView;
- (BYBlogViewPresenter *)presenter;
@end
