//
//  BYRACBaseViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseViewController.h"

@interface BYRACBaseViewController ()

@end

@implementation BYRACBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BYRACBaseViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewController);
        [viewController by_addSubviews];
        [viewController by_bindViewModel];
        viewController.view.backgroundColor = [UIColor whiteColor];
    }];
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewController);
        [viewController by_layoutNavigation];
        [viewController by_getNewData];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(id<BYRACViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)by_addSubviews {}
- (void)by_bindViewModel {}
- (void)by_layoutNavigation {}
- (void)by_getNewData {}

@end
