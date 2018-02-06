//
//  BYLinkedListNode.h
//  LearningRecord
//
//  Created by by_r on 2018/2/6.
//  Copyright © 2018年 by_r. All rights reserved.
//  双向链表抽象数据类型

#import <Foundation/Foundation.h>
/// 节点
@interface BYLinkedListNode : NSObject
@property (nonatomic, weak) BYLinkedListNode *previous;    ///< 直接前驱
@property (nonatomic, strong) BYLinkedListNode *next;      ///< 直接后继
@property (nonatomic, strong) id value;                 ///< 数据元素
- (instancetype)initWithValue:(id)value;
@end

@interface BYLinkedList : NSObject
@property (nonatomic, assign, getter=isEmpty, readonly) BOOL    empty;  ///< 是否为空链表
@property (nonatomic, assign, readonly) NSInteger   count;              ///< 链表中的元素数量
@property (nonatomic, strong, readonly) BYLinkedListNode    *first;       ///< 第一个元素
@property (nonatomic, strong, readonly) BYLinkedListNode    *last;        ///< 最后一个元素

/// 获取指定位置的元素
- (BYLinkedListNode *)nodeAtIndex:(NSInteger)index;
/// 在尾部插入一个元素
- (void)appendToTail:(id)value;
/// 在头部插入一个元素
- (void)insertToHead:(id)value;
/// 在指定位置插入一个节点
- (void)insert:(BYLinkedListNode *)node atIndex:(NSInteger)index;

/// 移除所有节点
- (void)removeAll;
/// 移除最后一个节点
- (id)removeLast;
/// 移除一个节点
- (id)remove:(BYLinkedListNode *)node;
/// 移除指定位置的节点
- (id)removeAtIndex:(NSInteger)index;

/// 打印所有节点
- (void)printAllNodes;
@end
