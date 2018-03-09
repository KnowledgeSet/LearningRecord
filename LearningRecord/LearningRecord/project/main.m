//
//  main.m
//  LearningRecord
//
//  Created by by_r on 2018/2/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYAppDelegate.h"
typedef void (^TestBlock)(void);
int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *test = @"test";
        TestBlock block = ^(void) {
            dispatch_sync(dispatch_queue_create("jd.test", DISPATCH_QUEUE_SERIAL), ^{
                NSLog(@"%@", test);
                NSLog(@">>>>>>>>>: %@", [NSThread currentThread]);
            });
        };
        test = @"test1";
        block();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([BYAppDelegate class]));
    }
}
