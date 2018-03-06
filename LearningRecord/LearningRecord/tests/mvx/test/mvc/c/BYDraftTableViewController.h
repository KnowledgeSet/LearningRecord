//
//  BYDraftTableViewController.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYDraft.h"
#import "BYUserAPIManager.h"
@interface BYDraftTableViewController : NSObject<UITableViewDelegate, UITableViewDataSource>
+ (instancetype)instanceWithUserId:(NSUInteger)userId;
- (UITableView *)tableView;
- (void)fetchData;
- (void)setDidSelectedRowHandler:(void(^)(BYDraft *draft))didSelectedRowHandler;
@end
