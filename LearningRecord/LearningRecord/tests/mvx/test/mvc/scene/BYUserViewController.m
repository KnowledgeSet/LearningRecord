//
//  BYUserViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYUserViewController.h"
#import "BYSelfViewController.h"

@interface BYUserViewController ()

@end

@implementation BYUserViewController

+ (instancetype)instanceWithUserId:(NSUInteger)userId {
    if (userId == LoginUserId) {
        return [[BYSelfViewController alloc] initWithUserId:userId];
    }
    return [[BYUserViewController alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configuration];
    [self addUI];
    [self fetchData];
}

- (void)configuration {
    self.title = [NSString stringWithFormat:@"用户%ld", self.userId];
    self.userInfoVC = [BYUserInfoViewController instancetypeWithUserId:self.userId];
    [self.userInfoVC setVCGenerator:^UIViewController *(id params) {
        return [BYUserDetailViewController instanceWithUser:params];
    }];
    
    self.blogVC = [BYBlogTableViewController instancetypeWithUserId:self.userId];
    [self.blogVC setVCGenerator:^UIViewController *(id params) {
        return [BYBlogDetailViewController instanceWithBlog:params];
    }];
    
    [self addChildViewController:self.userInfoVC];
}

- (void)addUI {
    CGFloat userInfoViewHeight = [BYUserInfoViewController viewHeight];
    self.userInfoVC.view.frame = CGRectMake(0, 0, BYSCREEN_WIDTH, userInfoViewHeight);
    [self.view addSubview:self.userInfoVC.view];
    
    self.blogVC.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.userInfoVC.view.frame), BYSCREEN_WIDTH, BYSCREEN_HEIGHT - CGRectGetMaxY(self.userInfoVC.view.frame));
    [self.view addSubview:self.blogVC.tableView];
}

- (void)fetchData {
    [self.userInfoVC fetchData];
    [self.blogVC fetchDataWithCompletionHandler:^(NSError *error, id result) {
        
    }];
}

@end
