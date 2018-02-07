//
//  BYQueue.h
//  LearningRecord
//
//  Created by by_r on 2018/2/7.
//  Copyright © 2018年 by_r. All rights reserved.
// 队列的抽象数据类型

#import <Foundation/Foundation.h>

@interface BYQueue<T> : NSObject
@property (nonatomic, assign, getter=isEmpty, readonly) BOOL    empty;  ///< 是否为空队列
@property (nonatomic, assign, readonly) NSInteger   count;              ///< 队列中的元素数量
@property (nonatomic, strong, readonly) T   front;                    ///< 队列头元素

/// 把元素插入队尾
- (void)enqueue:(T)element;
/// 删除队列头元素
- (T)dequeue;

/// 打印所有元素
- (void)printAllElements;
@end
