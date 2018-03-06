//
//  BYDraftViewController.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYDraftViewControllerPresenter.h"

@interface BYDraftViewController : NSObject<UITableViewDelegate, UITableViewDataSource>
+ (instancetype)instanceWithPresenter:(BYDraftViewControllerPresenter *)presenter;
- (UITableView *)tableView;
- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)handler;
- (void)setDidSelectedRowHandler:(void(^)(BYDraft *))didSelectedRowHandler;
@end
