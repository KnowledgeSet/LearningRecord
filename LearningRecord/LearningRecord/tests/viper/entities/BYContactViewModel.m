//
//  BYContactViewModel.m
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYContactViewModel.h"

@implementation BYContactViewModel

- (instancetype)initWithFullName:(NSString *)fullName {
    if (self = [super init]) {
        _fullName = fullName;
    }
    return self;
}

+ (BOOL)granthan:(BYContactViewModel *)lhs rhs:(BYContactViewModel *)rhs {
    return [lhs.fullName compare:rhs.fullName] == NSOrderedDescending;
}

+ (BOOL)lessthan:(BYContactViewModel *)lhs rhs:(BYContactViewModel *)rhs {
    return [lhs.fullName compare:rhs.fullName] == NSOrderedAscending;
}
@end
