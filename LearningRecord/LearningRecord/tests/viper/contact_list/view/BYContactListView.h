//
//  BYContactListView.h
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBaseViewController.h"
#import "BYContactListProtocols.h"

@interface BYContactListView : BYBaseViewController<BYContactListViewProtocol, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet    UITableView *tableView;
@end
