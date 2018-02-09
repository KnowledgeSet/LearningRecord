//
//  BYRACViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/2/8.
//  Copyright © 2018年 by_r. All rights reserved.
//
#import <ReactiveObjC/ReactiveObjC.h>
#import "BYRACViewController.h"

@interface BYRACViewController ()

@end

@implementation BYRACViewController

- (void)viewDidLoad {
    self.dataArray = [NSArray arrayWithObjects:
                      [NSStringFromSelector(@selector(testRACSignal)) stringByAppendingString:@",使用信号类步骤"],
                      nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testRACSignal {
    // 1.创建signal
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 3.1 发送next信号
        [subscriber sendNext:@"you jump i jump"];
        // 3.2 发送完成信号，并取消订阅
        [subscriber sendCompleted];
        
        // 4. 用于取消订阅时清理资源，释放对象
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    // 2. 订阅next信号、错误信号、完成信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
}

@end
