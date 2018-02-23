//
//  BYRACViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/2/8.
//  Copyright © 2018年 by_r. All rights reserved.
//
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACReturnSignal.h>
#import "BYRACViewController.h"

@interface BYRACViewController ()

@end

@implementation BYRACViewController

- (void)viewDidLoad {
    self.dataArray = [NSArray arrayWithObjects:
                      [NSStringFromSelector(@selector(testRACSignal)) stringByAppendingString:@",使用信号类步骤"],
                      NSStringFromSelector(@selector(testRACSubject)),
                      NSStringFromSelector(@selector(testRACCommand)),
                      [NSStringFromSelector(@selector(testBind)) stringByAppendingString:@",方法绑定"],
                      nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testRACSignal {
    // 1.创建signal
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 3.1 发送next信号
        [subscriber sendNext:@"you jump i jump"];
        [subscriber sendNext:@"second disposable"];
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

- (void)testRACSubject {
    // 1. 创建信号
    RACSubject *subject = [RACSubject subject];
    // 2. 订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
    // 3. 发送信号
    [subject sendNext:@"subject send next"];
}

- (void)testRACCommand {
    // 1. 创建命令 返回的是信号
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:input];
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
    // 2. 订阅命令发出的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
    // 3. 判断命令是否正在执行
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing next: %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"executing error: %@", error.description);
    } completed:^{
        NSLog(@"executing completed");
    }];
    // 4. 执行命令
    [command execute:@"test command"];
}

- (void)testBind {
    // 1. 创建源信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 4. 发送源信号
        [subscriber sendNext:@"today is sun day"];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    // 2. 绑定源信号，生成绑定信号
    RACSignal *bindSignal = [signal bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal *(id value, BOOL *stop) {
            return [RACReturnSignal return:[NSString stringWithFormat:@"%@ 123", value]];
        };
    }];
    // 3. 订阅绑定信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
}


@end
