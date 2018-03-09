//
//  NSArray+BYContactArray.m
//  LearningRecord
//
//  Created by by_r on 2018/3/9.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "NSArray+BYContactArray.h"

@implementation NSArray (BYContactArray)
- (NSInteger)insertionIndexOf:(BYContactViewModel *)contact {
    NSInteger lo = 0, hi = self.count - 1;
    while (lo <= hi) {
        NSInteger mid = (lo + hi) / 2;
        if ([BYContactViewModel lessthan:self[mid] rhs:contact]) {
            lo = mid + 1;
        }
        else if ([BYContactViewModel granthan:self[mid] rhs:contact]) {
            hi = mid - 1;
        }
        else {
            return mid;
        }
    }
    return lo;
}
@end
