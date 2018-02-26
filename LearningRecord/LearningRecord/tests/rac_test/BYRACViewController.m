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
#import "BYRACCircleListViewController.h"

@interface RACPerson : NSObject
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, assign) BOOL  sex;
@property (nonatomic, strong) NSNumber  *money;

+ (instancetype)personWithDict:(NSDictionary *)dict;
@end
@implementation RACPerson
+ (instancetype)personWithDict:(NSDictionary *)dict {
    RACPerson *person = [[RACPerson alloc] init];
    person.age = [dict[@"age"] integerValue];
    person.name = dict[@"name"];
    person.sex = [dict[@"sex"] boolValue];
    person.money = dict[@"money"];
    return person;
}
@end

@interface BYRACViewController ()

@end

@implementation BYRACViewController

- (void)viewDidLoad {
    self.dataArray = [NSArray arrayWithObjects:
                      [NSStringFromSelector(@selector(testRACSignal)) stringByAppendingString:@",使用信号类步骤"],
                      [NSStringFromSelector(@selector(testRACSubject)) stringByAppendingString:@",先订阅 后发送"],
                      [NSStringFromSelector(@selector(testRACReplaySubject)) stringByAppendingString:@",先发送 后订阅"],
                      NSStringFromSelector(@selector(testRACCommand)),
                      [NSStringFromSelector(@selector(testBind)) stringByAppendingString:@",方法绑定"],
                      [NSStringFromSelector(@selector(testMap)) stringByAppendingString:@",映射方法"],
                      [NSStringFromSelector(@selector(testObserverEvent)) stringByAppendingString:@",监听按钮点击事件、通知、定时器、过滤信号、KVO、代理"],
                      [NSStringFromSelector(@selector(testRACConnection)) stringByAppendingString:@",写网络请求的地方"],
                      [NSStringFromSelector(@selector(testRACSequence)) stringByAppendingString:@",RACSequence这个类可以代替NSArray或NSDictionary，主要用来快速遍历和字典转模型"],
                      [NSStringFromSelector(@selector(testRACLiftSelector)) stringByAppendingString:@",与GCD的group类似，多个线程任务执行完成之后再操作另一事件"],
                      [NSStringFromSelector(@selector(testIgnore)) stringByAppendingString:@",忽略信号"],
                      [NSStringFromSelector(@selector(testTake)) stringByAppendingString:@",指定个数获取信号"],
                      [NSStringFromSelector(@selector(testTakeUntil)) stringByAppendingString:@",使用标记信号来结束信号"],
                      [NSStringFromSelector(@selector(testDistinctUntilChanged)) stringByAppendingString:@",去重相同的信号"],
                      NSStringFromSelector(@selector(testRACLoginWithMVVM)),
                      [NSStringFromSelector(@selector(testRACAndMVVMWithList)) stringByAppendingString:@",搭建列表界面实践操作RAC与MVVM"],
                      
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
/// 只能先订阅，后发送
- (void)testRACSubject {
    // 1. 创建信号
    RACSubject *subject = [RACSubject subject];
    [subject sendNext:@"测试 收不到消息的"];
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
/// 可以先发送，再订阅
- (void)testRACReplaySubject {
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject sendNext:@"send message before subscribe"];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
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

- (void)testMap {
    // 1. 创建源信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       // 4. 发送源信号
        [subscriber sendNext:@"give you face"];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    // 2. 绑定源信号 生成绑定信号
    RACSignal *bindSignal = [signal map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%@ no face", value];
    }];
    // 3. 订阅绑定信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
    
    
    RACSubject *subject = [RACSubject subject];
    RACSignal *signal2 = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        value = [NSString stringWithFormat:@"%@ ???", value];
        return [RACReturnSignal return:value];
    }];
    [signal2 subscribeNext:^(id  _Nullable x) {
        NSLog(@"flattenMap next: %@", x);
    }];
    [subject sendNext:@"test flatten map"];
    
    // 处理信号中的信号
    RACSubject *subjectOfSignal = [RACSubject subject];
    RACSubject *subject12 = [RACSubject subject];
    // 1.双重订阅
    [subjectOfSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"- %@", x);
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"-- %@", x);
        }];
    }];
    // 2.订阅最新信号
    [subjectOfSignal.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"--- %@", x);
    }];
    // 3.映射
    [[subjectOfSignal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"---- %@", x);
    }];
    [subjectOfSignal sendNext:subject12];
    [subject12 sendNext:@"signal of signal"];
}

- (void)testObserverEvent {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"RACTest" bundle:nil];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"ractest"];
    [self.navigationController pushViewController:vc animated:YES];
}
/// 测试网络请求
- (void)testRACConnection {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求");
        [subscriber sendNext:@"返回请求数据"];
        return nil;
    }];
    /*
     多次订阅会发送多次请求，而网络请求一般只需请求一次，因此这种写法不适合
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1: %@", x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2: %@", x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"3: %@", x);
    }];
     */
    RACMulticastConnection *connect = [signal publish];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1: %@", x);
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2: %@", x);
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"3: %@", x);
    }];
    [connect connect];
}

- (void)testRACSequence {
    // 代替数组
    NSArray *array = @[@"邪恶小法师", @"熔岩巨兽", @"曙光女神", @18, @5];
//    RACSequence *sequence = array.rac_sequence;
//    RACSignal *signal = sequence.signal;
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"next: %@", x);
//    }];
    // 使用链式语法
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    }];
    
    // 代替字典
    NSDictionary *dict = @{@"小法" : @"邪恶小法师",
                           @"石头人" : @"熔岩巨兽",
                           @"日女" : @"曙光女神",
                           @"等级" : @18,
                           @"杀" : @5
                           };
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"dict next: %@", x); // 通过打印发现是个数组，第一个值为key，第二个值为value
//        NSLog(@"key: %@, value: %@", x.first, x.last);
        // 简单写法
        RACTupleUnpack(NSString *key, id value) = x;
        NSLog(@"%@=%@", key, value);
    }];
    
    // 字典转模型
    NSArray *jsonArray = @[@{@"age":@18,
                             @"name":@"A",
                             @"sex":@0,
                             @"money":@4.56
                             },
                           @{@"age":@28,
                             @"name":@"B",
                             @"sex":@1,
                             @"money":@40.56
                             },
                           @{@"age":@30,
                             @"name":@"C",
                             @"sex":@0,
                             @"money":@4.5694828494284
                             },
                           ];
//    NSMutableArray *persons = [NSMutableArray array];
//    [jsonArray.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        [persons addObject:[RACPerson personWithDict:x]];
//    }];
    NSArray *persons = [[jsonArray.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [RACPerson personWithDict:value];
    }] array];
    NSLog(@"%@", persons);
}

- (void)testRACLiftSelector {
    // block在主线程，如有耗时操作需放入子线程
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"1 %@", [NSThread currentThread]);
        [subscriber sendNext:@"任务1"];
        return nil;
    }];
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"任务2"];
        return nil;
    }];
    RACSignal *signal3 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"任务3"];
        return nil;
    }];
    NSLog(@"2 %@", [NSThread currentThread]);
    [self rac_liftSelector:@selector(updateUI:second:third:) withSignalsFromArray:@[signal1, signal2, signal3]];
}

- (void)updateUI:(id)first second:(id)second third:(id)third {
    NSLog(@"3 %@", [NSThread currentThread]);
    NSLog(@"%@, %@, %@", first, second, third);
}
/// 忽略信号
- (void)testIgnore {
    RACSubject *subject = [RACSubject subject];
    // 忽略掉值为 a 的信号  [subject ignoreValues]忽略所有的值
    [[subject ignore:@"a"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    }];
    [subject sendNext:@"a"];
    [subject sendNext:@"a1"];
    [subject sendNext:@"b"];
    
    [[[[subject ignore:@"1"] ignore:@"2"] ignore:@"3"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"-next: %@", x);
    }];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendNext:@"4"];
}
/// 指定哪些信号
- (void)testTake {
    RACSubject *subject = [RACSubject subject];
    // 正序
    [[subject take:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"take: %@", x);
    }];
    [subject sendNext:@"a"];
    [subject sendNext:@"b"];
    [subject sendNext:@"c"];
    [subject sendNext:@"d"];
    [subject sendNext:@"e"];
    // 倒序
    [[subject takeLast:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"takeLast: %@", x);
    }];
    [subject sendNext:@"a"];
    [subject sendNext:@"b"];
    [subject sendNext:@"c"];
    [subject sendNext:@"d"];
    [subject sendNext:@"e"];
    // 使用takeLast时一定要调用完成方法，否则就是不知道什么时候结束，无法获取倒序信号
    [subject sendCompleted];
}
/// 标记
- (void)testTakeUntil {
    // 需要一个信号作为标记，当标记的信号发送数据，就停止
    RACSubject *subject = [RACSubject subject];
    RACSubject *markSubject = [RACSubject subject];
    [[subject takeUntil:markSubject] subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    }];
    [markSubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"mark: %@", x);
    }];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    
    [markSubject sendNext:@"stop"];
    
    [subject sendNext:@"3"];
    [subject sendNext:@"4"];
}
/// 去重相同信号
- (void)testDistinctUntilChanged {
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    }];
    [subject sendNext:@"x"];
    [subject sendNext:@"x"];
    [subject sendNext:@"x"];
    // 还可以忽略数组、字典，但是不可以忽略模型
    [subject sendNext:@[@1]];
    [subject sendNext:@[@1]];
    
    [subject sendNext:@{@"name":@"jack"}];
    [subject sendNext:@{@"name":@"jack"}];
    
    RACPerson *p1 = [[RACPerson alloc] init];
    p1.name = @"jack";
    p1.age = 20;
    RACPerson *p2 = [[RACPerson alloc] init];
    p2.name = @"jack";
    p2.age = 20;
    [subject sendNext:p1];
    [subject sendNext:p2];
}

- (void)testRACLoginWithMVVM {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"RACTest" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testRACAndMVVMWithList {
    BYRACCircleListViewController *vc = [[BYRACCircleListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
