//
//  BYDataStructVC.m
//  LearningRecord
//
//  Created by by_r on 2018/2/7.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYDataStructVC.h"
#import "BYLinkedList.h"

@interface BYDataStructVC ()

@end

@implementation BYDataStructVC

- (void)viewDidLoad {
    self.dataArray = [NSArray arrayWithObjects:
                      NSStringFromSelector(@selector(linkedListTest)),
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
    
    [list removeLast];
    [list removeAtIndex:3];
    [list printAllNodes];
    
    [list removeAll];
    [list printAllNodes];
}

@end
