//
//  BYBlogTableViewController.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYUserAPIManager.h"
@interface BYBlogTableViewController : NSObject<UITableViewDelegate, UITableViewDataSource>
+ (instancetype)instancetypeWithUserId:(NSUInteger)userId;
- (UITableView *)tableView;
- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)handler;
- (void)setVCGenerator:(ViewControllerGenerator)VCGenerator;
@end
