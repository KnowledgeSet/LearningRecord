//
//  BYTableViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/2/6.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYTableViewController.h"

@interface BYTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

@end
