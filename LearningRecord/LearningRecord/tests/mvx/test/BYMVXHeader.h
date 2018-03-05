//
//  BYMVXHeader.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#ifndef BYMVXHeader_h
#define BYMVXHeader_h
#import <UIKit/UIKit.h>
#import <ReactiveObjc/ReactiveObjC.h>
#import "BYMacro.h"
#import "UIView+BYController.h"
#import "UIView+BYExt.h"
#import "UIResponder+BYRouter.h"

typedef void(^NetworkCompletionHandler)(NSError *error, id result);
typedef UIViewController *(^ViewControllerGenerator)(id params);

typedef NS_ENUM(NSUInteger, NetworkError) {
    NetworkErrorNoData,
    NetworkErrorNoMoreData,
};

#endif /* BYMVXHeader_h */
