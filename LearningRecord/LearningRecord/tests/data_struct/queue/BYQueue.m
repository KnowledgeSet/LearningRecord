//
//  BYQueue.m
//  LearningRecord
//
//  Created by by_r on 2018/2/7.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYQueue.h"

@interface BYQueue ()
{
    @private
    NSMutableArray  *_queueArray;
}
@end

@implementation BYQueue
- (instancetype)init {
    self = [super init];
    if (self) {
        _queueArray = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEmpty {
    return _queueArray.count == 0;
}

- (NSInteger)count {
    return _queueArray.count;
}

- (id)front {
    if (self.isEmpty) {
        NSLog(@"queue is empty");
        return nil;
    }
    return [_queueArray firstObject];
}

- (void)enqueue:(id)element {
    @synchronized(self) {
        if (element) {
            [_queueArray addObject:element];
        }
    }
}

- (id)dequeue {
    @synchronized(self) {
        if (self.isEmpty) {
            NSLog(@"queue is empty");
            return nil;
        }
        id obj = [_queueArray firstObject];
        [_queueArray removeObject:obj];
        return obj;
    }
}

- (void)printAllElements {
    if (self.isEmpty) {
        NSLog(@"queue is empty");
        return;
    }
    NSMutableString *logStr = [NSMutableString stringWithString:@"\nprint all queue elements:\n"];
    [_queueArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [logStr appendFormat:@"[%@]->%@->%p\n",@(idx),obj,obj];
    }];
    NSLog(@"%@", logStr);
}
@end
