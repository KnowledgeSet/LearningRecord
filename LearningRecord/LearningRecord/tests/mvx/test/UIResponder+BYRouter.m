//
//  UIResponder+BYRouter.m
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "UIResponder+BYRouter.h"

@implementation UIResponder (BYRouter)
- (void)routerEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [self.nextResponder routerEvent:eventName userInfo:userInfo];
}
@end
