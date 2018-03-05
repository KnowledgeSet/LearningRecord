//
//  UIResponder+BYRouter.h
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (BYRouter)
- (void)routerEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end
