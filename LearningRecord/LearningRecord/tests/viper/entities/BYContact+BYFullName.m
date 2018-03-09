//
//  BYContact+BYFullName.m
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYContact+BYFullName.h"
#import <objc/runtime.h>

@implementation BYContact (BYFullName)
//- (void)setFullName:(NSString *)fullName {
//    NSMutableString *name = [@"" mutableCopy];
//    if (self.firstName) {
//        [name appendString:self.firstName];
//    }
//    if (self.lastName) {
//        [name appendString:self.lastName];
//    }
//    objc_setAssociatedObject(self, _cmd, name, OBJC_ASSOCIATION_RETAIN);
//}
//
//- (NSString *)fullName {
//    return objc_getAssociatedObject(self, _cmd);
//}

- (NSString *)fullName {
    NSMutableString *name = [@"" mutableCopy];
    if (self.firstName) {
        [name appendString:self.firstName];
    }
    if (self.lastName) {
        [name appendString:self.lastName];
    }
    return name;
}
@end

