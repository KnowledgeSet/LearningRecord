//
//  BYBlogView.h
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYBlogViewModel.h"
@interface BYBlogView : NSObject<UITableViewDelegate, UITableViewDataSource>
+ (instancetype)instanceWithViewModel:(BYBlogViewModel *)viewModel;
- (UITableView *)tableView;
- (RACCommand *)fetchDataCommand;
- (void)setDidSelectedRowCommand:(RACCommand *)didSelectedRowCommand;
@end
