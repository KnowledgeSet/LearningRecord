//
//  BYDataStructVC.m
//  LearningRecord
//
//  Created by by_r on 2018/2/7.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYDataStructVC.h"
#import "BYLinkedList.h"
#import "BYStack.h"
#import "BYQueue.h"

@interface BYDataStructVC ()

@end

@implementation BYDataStructVC

- (void)viewDidLoad {
    self.dataArray = [NSArray arrayWithObjects:
                      NSStringFromSelector(@selector(linkedListTest)),
                      NSStringFromSelector(@selector(stackTest)),
                      NSStringFromSelector(@selector(queueTest)),
                      nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)linkedListTest {
    BYLinkedList *list = [[BYLinkedList alloc] init];
    [list insertToHead:@"linked"];
    [list insert:[[BYLinkedListNode alloc] initWithValue:@"list"] atIndex:1];
    [list appendToTail:@"is"];
    [list insertToHead:@"the"];
    [list printAllNodes];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"main ----------");
        [list removeLast];
        [list removeAtIndex:3];
        [list printAllNodes];
        NSLog(@"main ----------");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"global ----------");
        [list removeAll];
        [list printAllNodes];
        NSLog(@"global ----------");
    });
    NSLog(@"thread ---------");
    [list removeLast];
    [list removeAtIndex:3];
    [list printAllNodes];
    
    [list removeAll];
    [list printAllNodes];
    NSLog(@"thread ---------");
}

- (void)stackTest {
    BYStack *stack = [[BYStack alloc] init];
    NSLog(@"empty: %d, top: %@", stack.isEmpty, stack.top);
    [stack push:@"stack"];
    NSLog(@"empty: %d, top: %@", stack.isEmpty, stack.top);
    [stack push:@"is"];
    [stack printAllElements];
    [stack push:@"LIFO"];
    [stack printAllElements];
    [stack pop];
    [stack printAllElements];
    [stack pop];
    [stack pop];
    [stack printAllElements];
}

- (void)queueTest {
    BYQueue *queue = [[BYQueue alloc] init];
    NSLog(@"queue is empty: %d, front: %@", queue.isEmpty, queue.front);
    [queue enqueue:@2];
    NSLog(@"queue is empty: %d, front: %@", queue.isEmpty, queue.front);
    [queue enqueue:@3];
    [queue printAllElements];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"11 -----------");
        [queue enqueue:@"hello"];
        [queue printAllElements];
        NSLog(@"11 -----------");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"22 -----------");
//        [queue enqueue:@"world"];
        [queue dequeue];
        [queue printAllElements];
        NSLog(@"22 -----------");
    });
    NSLog(@"33 -----------");
    [queue dequeue];
    [queue printAllElements];
    NSLog(@"33 front: %@", queue.front);
    NSLog(@"44 -----------");
    [queue dequeue];
    [queue printAllElements];
    NSLog(@"44 front: %@", queue.front);
    NSLog(@"55 -----------");
    [queue dequeue];
    [queue printAllElements];
    NSLog(@"55 front: %@", queue.front);
}

@end
