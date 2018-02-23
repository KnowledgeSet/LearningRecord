//
//  BYRACTestVC.m
//  LearningRecord
//
//  Created by by_r on 2018/2/23.
//  Copyright © 2018年 by_r. All rights reserved.
//
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import "BYRACTestVC.h"

@interface BYRedView : UIView
@end
@implementation BYRedView
- (IBAction)btnAction:(id)sender {
    NSLog(@"按钮绑定事件");
}
@end

@interface BYRACTestVC ()
@property (weak, nonatomic) IBOutlet    UIView  *redView;

@property (weak, nonatomic) IBOutlet    UIButton    *btn;

@property (weak, nonatomic) IBOutlet    UITextField *textField;
@property (weak, nonatomic) IBOutlet    UILabel *label;

@property (weak, nonatomic) IBOutlet    UIButton    *countdownButton;
@property (assign, nonatomic) NSInteger time;
@property (strong, nonatomic) RACDisposable *disposable;
@end

@implementation BYRACTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark    /// 替代代理
    @weakify(self);
    [[self.redView rac_signalForSelector:@selector(btnAction:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        NSLog(@"监听按钮事件: %@", x);
        self.redView.frame = CGRectMake(50, 100, 200, 200);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
    
#pragma mark    /// KVO
    // 1.
//    [self.redView rac_observeKeyPath:@"frame"
//                             options:NSKeyValueObservingOptionNew
//                            observer:nil
//                               block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//                                   NSLog(@"value: %@, change: %@, %d, %d", value, change, causedByDealloc, affectedOnlyLastComponent);
//                               }];
    // 2.
//    [[self.redView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"next: %@", x);
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"error: %@", error.description);
//    } completed:^{
//        NSLog(@"completed");
//    }];
    // 3.
    [RACObserve(self.redView, frame) subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
    
#pragma mark    /// 监听事件
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"next: %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
    
#pragma mark     /// 通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"next: %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
    } completed:^{
        NSLog(@"completed");
    }];
    
#pragma mark    /// 监听输入 过滤信号
//    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"textfield next: %@", x);
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"error: %@", error.description);
//    } completed:^{
//        NSLog(@"completed");
//    }];
    [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 5;
    }] subscribeNext:^(NSString * _Nullable x) {
        // 当字符长度大于5时才会调用输出
        NSLog(@"textfield: %@", x);
    }];
    RAC(_label, text) = _textField.rac_textSignal;
    
#pragma mark    /// 倒计时
    [[_countdownButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        x.enabled = false;
        self.time = 5;
        /// RAC的GCD
        self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            _time --;
            NSString *title = _time > 0 ? [NSString stringWithFormat:@"请等待 %ld 秒后", (long)_time] : @"发送验证码";
            [self.countdownButton setTitle:title forState:UIControlStateNormal | UIControlStateDisabled];
            self.countdownButton.enabled = _time == 0;
            if (_time == 0) {
                [self.disposable dispose];
            }
        }];
    }];
}


@end
