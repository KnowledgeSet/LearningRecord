//
//  BYUserViewController.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBaseViewController.h"
#import "BYUserInfoViewController.h"
#import "BYDetailViewController.h"
#import "BYBlogTableViewController.h"

#define LoginUserId 123

@interface BYUserViewController : BYBaseViewController
+ (instancetype)instanceWithUserId:(NSUInteger)userId;
@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) BYUserInfoViewController  *userInfoVC;
@property (nonatomic, strong) BYBlogTableViewController *blogVC;

- (void)addUI;
- (void)fetchData;
- (void)configuration;
@end
