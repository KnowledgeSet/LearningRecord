//
//  BYInterviewVC.m
//  LearningRecord
//
//  Created by by_r on 2018/3/10.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYInterviewVC.h"
#import <objc/runtime.h>

@interface RuntimeMethodHelper : NSObject

@end

@implementation RuntimeMethodHelper
- (void)hello {
    NSLog(@"%@, %p", self, _cmd);
}
@end

@interface HelloClass : NSObject
{
    RuntimeMethodHelper *_helper;
}
- (void)hello;
+ (instancetype)hi;
@end

void functionForMethod(id self, SEL _cmd) {
    NSLog(@"Hello!");
}

Class functionForClassMethod(id self, SEL _cmd) {
    NSLog(@"Hi!");
    return [HelloClass class];
}

@implementation HelloClass
- (instancetype)init {
    if (self = [super init]) {
        _helper = [[RuntimeMethodHelper alloc] init];
    }
    return self;
}
#pragma mark - 动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"resolveInstanceMethod");
//    NSString *selString = NSStringFromSelector(sel);
//    if ([selString isEqualToString:@"hello"]) {
//        class_addMethod(self, @selector(hello), (IMP)functionForMethod, "v@:");
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"resolveClassMethod");
    NSString *selString = NSStringFromSelector(sel);
    if ([selString isEqualToString:@"hi"]) {
        Class metaClass = objc_getMetaClass("HelloClass");
        class_addMethod(metaClass, @selector(hi), (IMP)functionForClassMethod, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}
#pragma mark - 备用接收者  动态方法中不处理会调用这个方法
// 这个备用接受者只能是一个新的对象，不能是self本身，否则就会出现无限循环。
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector");
//    NSString *selectorString = NSStringFromSelector(aSelector);
//    if ([selectorString isEqualToString:@"hello"]) {
//        // 将消息交给_helper处理
//        return _helper;
//    }
    return [super forwardingTargetForSelector:aSelector];
}
#pragma mark - 完整消息转发 备用方法中不处理会调用下面两个方法
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation");
    if ([RuntimeMethodHelper instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_helper];
    }
    [super forwardInvocation:anInvocation];
}
// 必须重写这个方法，消息转发机制使用从这个方法中获取的信息来创建NSInvocation对象
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if ([RuntimeMethodHelper instancesRespondToSelector:aSelector]) {
            signature = [RuntimeMethodHelper instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature;
}
#pragma mark - 消息最终未处理调用
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"doesNotRecognizeSelector");
    NSString *selString = NSStringFromSelector(aSelector);
    if ([selString isEqualToString:@"hello"]) {
        
    }
    else {
        [super doesNotRecognizeSelector:aSelector];
    }
}
@end

@interface BYInterviewVC ()
@property (nonatomic, assign) NSTimeInterval    time;
@property (nonatomic, strong) NSTimer   *timer;

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, assign) BOOL  isStart;

@property (nonatomic, copy) NSString    *kvoString;
@end

@implementation BYInterviewVC
- (void)dealloc {
    _isStart = NO;
    /*
     // 这段代码会崩溃，原因是不允许在 dealloc 中取 weakSelf;
     // 查看 weak_register_no_lock 函数代码，发现 runtime 是通过检查引用计数的个数来判断对象是否在 deallocting，然后通过 if (deallocting) 使程序崩溃。
    __weak typeof(self) weakSelf = self;
    NSLog(@"%@", weakSelf);
    // Cannot form weak reference to instance (0x7f89dec0a0e0) of class BYInterviewVC. It is possible that this object was over-released, or is in the process of deallocation.
     */
}

- (void)viewDidLoad {
    self.dataArray = [NSArray arrayWithObjects:
                      [NSStringFromSelector(@selector(testTimer)) stringByAppendingString:@",以schedule开头的方法会自动把timer加入当前run loop，其他的则需要手动添加才会有效。为了使定时器在页面滑动时正常运行，需要确保defaultModel和trackingModel里都添加了定时器。"],
                      [NSStringFromSelector(@selector(testQueue)) stringByAppendingString:@", 进入页面时添加任务到后台线程，退出页面时，如何取消未完成的任务？"],
                      [NSStringFromSelector(@selector(testBlock)) stringByAppendingString:@", 输出结果是什么？语句在哪条线程执行？为什么？"],
                      [NSStringFromSelector(@selector(testKVOString)) stringByAppendingString:@", 基本原理/深入原理"],
                      [NSStringFromSelector(@selector(testMessageInvokeInstance)) stringByAppendingString:@", 消息转发机制原理"],
                      NSStringFromSelector(@selector(testMessageInvokeClass)),
                       nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.kvoString = @"oldString";
    [self addObserver:self forKeyPath:@"self.kvoString" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 在使用NSTimer时应注意：
 
 （1）使用NSTimer时，timer会保持对target和userInfo参数的强引用。只有当调取了NSTimer的invalidate方法时，NSTimer才会释放target和userInfo。生成timer的方法中如果repeats参数为NO，则定时器触发后会自动调取invalidate方法。如果repeats参数为YES，则需要程序员手动调取invalidate方法才能释放timer对target和userIfo的强引用。
 
 （2）在使用repeats参数为YES的定时器时，如果在使用完定时器时后没有调取invalidate方法，导致target和userInfo没有被释放，则可能会形成循环引用情况，从而影响内存释放。
 */
- (void)testTimer {
    _time = 10;
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [_timer fire];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    // 或者直接使用 NSRunLoopCommonModes;
}

- (void)countDown {
    if (_time > 0) {
        _time --;
    }
    else {
        [_timer invalidate];
    }
    NSLog(@"%f", _time);
}

- (void)testQueue {
    /*
     设置一个全局标识 isStart = YES，在队列中异步执行任务时，判断这个标识 isStart 是否为YES，如果是YES则执行。当页面退出时，我们在 dealloc 方法中设置为 isStart = NO，则队列中的任务将不再会执行，也就相当于是取消了未执行的任务。
     不使用 stop 来判断是因为即便设置 stop = YES, 但页面释放后，self 为 nil，self.stop 为 NO，还是会继续执行。
     */
    _isStart = YES;
    
    self.queue = dispatch_queue_create("jd.test", DISPATCH_QUEUE_SERIAL);
    __weak typeof(&*self) weakSelf = self;
    for (NSInteger i = 0; i < 10000; i ++) {
        dispatch_async(self.queue, ^{
            if (weakSelf.isStart) {
                NSLog(@"%ld -> %d -> %@", i, weakSelf.isStart, weakSelf);
            }
        });
    }
}

typedef void (^TestBlock)(void);
- (void)testBlock {
    NSString *test = @"test";
    TestBlock block = ^{
        dispatch_sync(dispatch_queue_create("jd.test", DISPATCH_QUEUE_SERIAL), ^{
            NSLog(@"%@", test);
            NSLog(@">>>>>>>>>> %@", [NSThread currentThread]);
        });
    };
    test = @"test1";
    block();
    // test 主线程  同步执行
}

/*
 KVO基本原理：KVO是基于runtime机制实现的。当某个类的属性对象第一次被观察时，系统会在运行期间动态创建一个该类的派生类，在派生类中重写被观察属性的setter方法，
            在被重写的setter方法内实现真正的通知机制。如果原类为Person，那么派生类名为NSKVONotifying_Person。每个类对象都有一个isa指针指向当前类，
            当属性对象第一次被观察，系统会偷偷将isa指针指向动态生成的派生类，从而在给被观察属性赋值时执行派生类的setter方法。键值观察通知依赖于NSObject的
            两个方法：-willChangeValueForKey: 和 -didChangeValueForKey: ；在属性发生改变前，will一定会被调用，此时记录旧值；改变后，did被调用，
            继而 -obserValueForKey:也会被调用。
 KVO深入原理：1. Apple使用isa混写(isa-swizzling)来实现KVO。当观察对象A时，动态创建NSKVONotifying_A新类，该类继承自对象A本类，
            KVO为该类重写属性的setter方法，setter方法会负责在调用原来的setter方法之前和之后，通知所有观察对象属性值的变化。(因为是继承，所以在派生类中使用super调用父类setter方法，并不操作值。)
            2.在这个过程中，被观察对象的isa指针从指向原来的A类变为指向派生类。
            3.(isa指针的作用：每个对象都有isa指针指向该对象的类，它告诉runtime该对象的类是什么。当对象注册为观察者时，isa指针指向派生类，被观察的对象就变成了派生类的
            对象(或实例)了。)因而在该对象上调用setter就会调用已重写的setter，从而激活键值通知机制。
            4.键值观察通知依赖于NSObject的两个方法：-willChangeValueForKey: 和 -didChangeValueForKey: ；在属性发生改变前，will一定会被调用，
            通知系统该keyPath的属性值即将变更；改变后，did被调用，通知系统该keyPath的属性值已经变更，继而 -obserValueForKey:也会被调用。
            且重写观察属性的setter方法这种继承方式是在运行时而不是编译时实现的。
 
 */
- (void)testKVOString {
    self.kvoString = @"kvoString";
}

- (void)setKvoString:(NSString *)kvoString {
    _kvoString = kvoString;
}

- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"%@", self.kvoString);
    [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"%@", self.kvoString);
    [super didChangeValueForKey:key];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", object);
}

/*
 先动态解析，没有响应该消息则检查是否有备用接受者，如果没有则检查是否有消息转发处理，如果都没有处理则执行未处理方法。
 */
- (void)testMessageInvokeInstance {
    HelloClass *hello = [[HelloClass alloc] init];
    [hello hello];
}

- (void)testMessageInvokeClass {
    [HelloClass hi];
}

@end





