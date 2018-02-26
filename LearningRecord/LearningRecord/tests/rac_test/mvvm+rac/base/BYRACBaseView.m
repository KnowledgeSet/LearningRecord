//
//  BYRACView.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseView.h"

@implementation BYRACBaseView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self by_setupViews];
        [self by_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<BYRACViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        [self by_setupViews];
        [self by_bindViewModel];
    }
    return self;
}

- (void)by_setupViews {}
- (void)by_bindViewModel {}

- (void)by_addReturnKeyboard {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}

@end
