//
//  BYTableViewController.h
//  LearningRecord
//
//  Created by by_r on 2018/2/6.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBaseViewController.h"

@interface BYTableViewController : BYBaseViewController
@property (nonatomic, retain) NSArray   *dataArray;
@property (nonatomic, strong, readonly) UITableView *myTableView;
@end
