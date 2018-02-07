//
//  BYStack.h
//  LearningRecord
//
//  Created by by_r on 2018/2/7.
//  Copyright © 2018年 by_r. All rights reserved.
// 栈的抽象数据类型
// 栈是限定仅在表的尾部进行插入和删除操作的线性表

#import <Foundation/Foundation.h>

@interface BYStack<T> : NSObject
@property (nonatomic, assign, getter=isEmpty, readonly) BOOL empty;     ///< 是否为空栈
@property (nonatomic, assign, readonly) NSInteger   count;            ///< 栈中的元素数量
@property (nonatomic, strong, readonly) T   top;                      ///< 栈顶的元素

/// 入栈
- (void)push:(T)element;
/// 出栈
- (T)pop;

/// 打印所有元素
- (void)printAllElements;
@end
