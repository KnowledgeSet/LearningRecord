//
//  BYLinkedListNode.m
//  LearningRecord
//
//  Created by by_r on 2018/2/6.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYLinkedList.h"

@implementation BYLinkedListNode
- (instancetype)initWithValue:(id)value {
    self = [super init];
    if (self) {
        self.value = value;
    }
    return self;
}
@end

@interface BYLinkedList ()
@property (nonatomic, strong) BYLinkedListNode  *head;
@end

@implementation BYLinkedList
- (BOOL)isEmpty {
    return _head == nil;
}

- (NSInteger)count {
    if (_head == nil) {
        return 0;
    }
    NSInteger count = 1;
    BYLinkedListNode *node = _head.next;
    while (node) {
        node = node.next;
        count ++;
    }
    return count;
}

- (BYLinkedListNode *)first {
    return _head;
}

- (BYLinkedListNode *)last {
    if (_head == nil) {
        return nil;
    }
    BYLinkedListNode *node = _head;
    while (node.next) {
        node = node.next;
    }
    return node;
}

- (BYLinkedListNode *)nodeAtIndex:(NSInteger)index {
    if (index == 0) {
        return _head;
    }
    if (index >= self.count) {
        return nil;
    }
    BYLinkedListNode *node = _head.next;
    for (NSInteger i = 1; i < index; i ++) {
        if (node == nil) {
            break;
        }
        node = node.next;
    }
    return node;
}

- (void)appendToTail:(id)value {
    BYLinkedListNode *newNode = [[BYLinkedListNode alloc] initWithValue:value];
    if (self.last == nil) {
        _head = newNode;
    }
    else {
        newNode.previous = self.last;
        self.last.next = newNode;
    }
}

- (void)insertToHead:(id)value {
    BYLinkedListNode *newHead = [[BYLinkedListNode alloc] initWithValue:value];
    if (_head == nil) {
        _head = newHead;
    }
    else {
        newHead.next = _head;
        _head.previous = newHead;
        _head = newHead;
    }
}

- (void)insert:(BYLinkedListNode *)node atIndex:(NSInteger)index {
    if (index < 0) {
        NSLog(@"index out of range");
        return;
    }
    
    if (self.count == 0) {
        _head = node;
    }
    else {
        if (index == 0) {
            node.next = _head;
            _head.previous = node;
            _head = node;
        }
        else {
            // 当index == self.count时，实际上是插入尾部，不算是越界，只是下面的next为空
            // 不在开始时判断是因为如果链表为空，则添加在头部
            if (index > self.count) {
                NSLog(@"index out of range");
                return;
            }
            BYLinkedListNode *prev = [self nodeAtIndex:index - 1];
            BYLinkedListNode *next = prev.next;
            
            node.previous = prev;
            node.next = next;
            prev.next = node;
            next.previous = node;
        }
    }
}

- (void)removeAll {
    // 此处描述的非循环链表，只需将头部置空即可
    _head = nil;
}

- (id)removeLast {
    if (self.isEmpty) {
        return nil;
    }
    return [self remove:self.last];
}

- (id)remove:(BYLinkedListNode *)node {
    if (_head == nil) {
        NSLog(@"linked list is empty");
        return nil;
    }
    BYLinkedListNode *prev = node.previous;
    BYLinkedListNode *next = node.next;
    if (prev) {
        prev.next = next;
    }
    else {
        _head = next;
    }
    next.previous = prev;
    
    node.previous = nil;
    node.next = nil;
    return node.value;
}

- (id)removeAtIndex:(NSInteger)index {
    if (_head == nil) {
        NSLog(@"linked list is empty");
        return nil;
    }
    BYLinkedListNode *node = [self nodeAtIndex:index];
    if (!node) {
        return nil;
    }
    return [self remove:node];
}

- (void)printAllNodes {
    if (_head == nil) {
        NSLog(@"linked list is empty");
        return;
    }
    BYLinkedListNode *node = _head;
    NSMutableString *logStr = [NSMutableString stringWithString:@"\nstart printing all nodes:\n"];
    for (NSInteger i = 0; i < self.count; i ++) {
        if (node == nil) {
            break;
        }
        NSString *str = [NSString stringWithFormat:@"[%@]->%@->%@\n",@(i),node.value,node];
        [logStr appendString:str];
        node = node.next;
    }
    NSLog(@"%@", logStr);
}
@end
