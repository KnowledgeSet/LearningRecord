//
//  BYMVXVC.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYMVXVC.h"
#import "BYUserViewController.h"
#import "BYMVPUserViewController.h"
#import "BYMVVMUserViewController.h"

@interface BYMVXVC ()

@end

@implementation BYMVXVC

- (void)viewDidLoad {
    self.dataArray = [NSArray arrayWithObjects:[NSStringFromSelector(@selector(lookOther)) stringByAppendingString:@",MVC-查看他人用户信息"],
                      [NSStringFromSelector(@selector(lookSelf)) stringByAppendingString:@",MVC-查看自己用户信息"],
                      [NSStringFromSelector(@selector(mvpLookSelf)) stringByAppendingString:@",MVP-查看自己用户信息"],
                      [NSStringFromSelector(@selector(mvvmLookSelf)) stringByAppendingString:@",MVVM-查看自己用户信息"],
                      
                      nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)lookOther {
    [self.navigationController pushViewController:[BYUserViewController instanceWithUserId:0] animated:YES];
}

- (void)lookSelf {
    [self.navigationController pushViewController:[BYUserViewController instanceWithUserId:123] animated:YES];
}

- (void)mvpLookSelf {
    [self.navigationController pushViewController:[BYMVPUserViewController instancetypeWithUserId:123] animated:YES];
}

- (void)mvvmLookSelf {
    [self.navigationController pushViewController:[BYMVVMUserViewController instancetypeWithUserId:123] animated:YES];
}

@end
