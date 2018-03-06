//
//  BYUser.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYUser.h"

@implementation BYUser
- (instancetype)initWithUserId:(NSUInteger)userId {
    
    self.name = [NSString stringWithFormat:@"user%lu",userId];
    self.icon = @"125.jpeg";//[NSString stringWithFormat:@"icon%lu.png", userId % 2];
    self.userId = userId;
    self.summary = [NSString stringWithFormat:@"userSummary%ld", userId];
    self.blogCount = userId + 8;
    self.friendCount = userId + 10;
    return self;
}
@end
