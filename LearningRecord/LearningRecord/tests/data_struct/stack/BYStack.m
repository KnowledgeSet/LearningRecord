//
//  BYStack.m
//  LearningRecord
//
//  Created by by_r on 2018/2/7.
//  Copyright © 2018年 by_r. All rights reserved.
// 

#import "BYStack.h"

@interface BYStack ()
{
    @private
    NSMutableArray  *_stackArray; ///< 使用数组来实现栈内部的线性表
}
@end

@implementation BYStack
- (instancetype)init {
    self = [super init];
    if (self) {
        _stackArray = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEmpty {
    return _stackArray.count == 0;
}

- (NSInteger)count {
    return _stackArray.count;
}

- (id)top {
    if (self.isEmpty) {
        return nil;
    }
    return [_stackArray lastObject];
}

- (void)push:(id)element {
    @synchronized(self) {
        if (element) {
            [_stackArray addObject:element];
        }
    }
}

- (id)pop {
    @synchronized(self) {
        if (self.isEmpty) {
            NSLog(@"stack is empty");
            return nil;
        }
        id obj = [_stackArray lastObject];
        [_stackArray removeLastObject];
        return obj;
    }
}

- (void)printAllElements {
    if (self.isEmpty) {
        NSLog(@"stack is empty");
        return;
    }
    NSMutableString *logStr = [NSMutableString stringWithString:@"\nprint all stack elements:\n"];
    [_stackArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [logStr appendFormat:@"[%@]->%@->%p\n",@(idx),obj,obj];
    }];
    NSLog(@"%@", logStr);
}
@end
