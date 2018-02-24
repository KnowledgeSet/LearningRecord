//
//  BYRACLoginVC.m
//  LearningRecord
//
//  Created by by_r on 2018/2/24.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACLoginVC.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "BYRACLoginViewModel.h"

@interface BYRACLoginVC ()
@property (nonatomic, weak) IBOutlet    UITextField *accountTextField;
@property (nonatomic, weak) IBOutlet    UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet    UIButton    *loginButton;

@property (nonatomic, strong) BYRACLoginViewModel   *loginVM;
@end

@implementation BYRACLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self normalMethod];
    [self vmMethod];
}

#pragma mark - normal
- (void)normalMethod {
    // 用户名长度不能少于1位，密码必须是六位及以上
    RAC(_loginButton, enabled) = [RACSignal combineLatest:@[_accountTextField.rac_textSignal, _passwordTextField.rac_textSignal] reduce:^id _Nullable(NSString *account, NSString *password){
        return @(account.length && (password.length > 5));
    }];
    
    [self buttonEvent];
}

- (void)buttonEvent {
    RACCommand *btnPressCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"拼接参数，准备发送登录请求: %@", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"开始请求");
            NSLog(@"请求成功");
            NSLog(@"处理数据");
            [subscriber sendNext:@"请求到的数据"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束了");
            }];
        }];
    }];
    [btnPressCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面: %@", x);
    }];
    [[btnPressCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行中...");
        }
        else {
            NSLog(@"执行结束了");
        }
    }];
    
    [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [btnPressCommand execute:@{@"account":_accountTextField.text, @"password":_passwordTextField.text}];
    }];
}
#pragma mark - vm
- (void)vmMethod {
    // 赋值
    RAC(self.loginVM, account) = _accountTextField.rac_textSignal;
    RAC(self.loginVM, password) = _passwordTextField.rac_textSignal;
    // 订阅信号
    RAC(_loginButton, enabled) = self.loginVM.btnEnableSignal;
    [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.loginVM.loginCommand execute:@{@"account":_accountTextField.text, @"password":_passwordTextField.text}];
    }];
    
    [self.loginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面: %@", x);
    }];
}

#pragma mark - lazy load
- (BYRACLoginViewModel *)loginVM {
    if (!_loginVM) {
        _loginVM = [[BYRACLoginViewModel alloc] init];
    }
    return _loginVM;
}

@end
