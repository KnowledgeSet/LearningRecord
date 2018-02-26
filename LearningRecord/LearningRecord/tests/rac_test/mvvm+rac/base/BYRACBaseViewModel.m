//
//  BYRACBaseViewModel.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseViewModel.h"

@implementation BYRACBaseViewModel
@synthesize request = _request;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BYRACBaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel by_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)by_initialize {}

- (BYRACRequest *)request {
    if (!_request) {
        _request = [BYRACRequest request];
    }
    return _request;
}

@end
