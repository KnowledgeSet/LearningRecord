//
//  BYSceneY.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYSceneY.h"
#import "BYDraftTableViewController.h"

@interface BYSceneY ()
@property (nonatomic, strong) BYDraftTableViewController    *draftVC;
@end

@implementation BYSceneY

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.draftVC = [BYDraftTableViewController instanceWithUserId:999];
    self.draftVC.tableView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.draftVC.tableView];
    [self.draftVC fetchData];
}


@end
