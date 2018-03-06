//
//  BYUser.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYUser : NSObject
- (instancetype)initWithUserId:(NSUInteger)userId;

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *summary;
@property (assign, nonatomic) NSUInteger userId;
@property (assign, nonatomic) NSUInteger blogCount;
@property (assign, nonatomic) NSUInteger friendCount;
@end
