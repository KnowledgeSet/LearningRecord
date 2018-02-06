//
//  BYLinkedListNode.h
//  LearningRecord
//
//  Created by by_r on 2018/2/6.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYLinkedListNode : NSObject
@property (nonatomic, weak) id previous;
@property (nonatomic, strong) id next;
@property (nonatomic, strong) id value;
- (instancetype)initWithValue:(id)value;
@end

@interface BYLinkedList : NSObject

@end
