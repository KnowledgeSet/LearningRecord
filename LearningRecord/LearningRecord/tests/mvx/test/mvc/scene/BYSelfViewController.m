//
//  BYSelfViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYSelfViewController.h"
#import "BYDraftTableViewController.h"

@interface BYSelfViewController ()
@property (nonatomic, strong) UIButton  *blogButton;
@property (nonatomic, strong) UIButton  *draftButton;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) BYDraftTableViewController    *draftVC;
@end

@implementation BYSelfViewController

- (void)switchTableView:(UIButton *)button {
    if (button == self.blogButton) {
        [self.scrollView setContentOffset:CGPointZero animated:YES];
        self.draftButton.selected = NO;
    }
    else {
        self.blogButton.selected = NO;
        [self.scrollView setContentOffset:CGPointMake(BYSCREEN_WIDTH, 0) animated:YES];
    }
    button.selected = YES;
}

- (void)configuration {
    [super configuration];
    self.title = @"我";
    self.draftVC = [BYDraftTableViewController instanceWithUserId:self.userId];
    __weak typeof(self) weakSelf = self;
    [self.draftVC setDidSelectedRowHandler:^(BYDraft *draft) {
        [weakSelf.navigationController pushViewController:[BYDraftDetailViewController instanceWithDraft:draft] animated:YES];
    }];
}

- (void)addUI {
    [super addUI];
    UIButton *(^makeButton)(NSString *, CGRect) = ^(NSString *title, CGRect frame) {
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(switchTableView:) forControlEvents:UIControlEventTouchUpInside];
        return button;
    };
    CGFloat switchButtonTop = self.userInfoVC.view.bottom;
    CGFloat switchButtonHeight = 40;
    [self.view addSubview:self.blogButton = makeButton(@"博客", CGRectMake(0, switchButtonTop, BYSCREEN_WIDTH * 0.5, switchButtonHeight))];
    [self.view addSubview:self.draftButton = makeButton(@"草稿", CGRectMake(self.blogButton.right, switchButtonTop, self.blogButton.width, switchButtonHeight))];
    self.blogButton.selected = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.blogButton.bottom, BYSCREEN_WIDTH, BYSCREEN_HEIGHT - self.blogButton.bottom)];
    scrollView.contentSize = CGSizeMake(BYSCREEN_WIDTH * 2, 0);
    scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView = scrollView];
    
    self.blogVC.tableView.frame = CGRectMake(0, 0, BYSCREEN_WIDTH, scrollView.height);
    [self.scrollView addSubview:self.blogVC.tableView];
    
    self.draftVC.tableView.frame = CGRectMake(BYSCREEN_WIDTH, 0, BYSCREEN_WIDTH, scrollView.height);
    [self.scrollView addSubview:self.draftVC.tableView];
}

- (void)fetchData {
    [super fetchData];
    [self.draftVC fetchData];
}

@end
