//
//  BYUserInfoController.h
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYUserInfoViewModel.h"
#import "BYUserInfoView.h"

@interface BYUserInfoController : NSObject
//+ (instancetype)instanceWithView:(BYUserInfoView *)view viewModel:(BYUserInfoViewModel *)viewModel;
//- (BYUserInfoView *)view;
//- (BYUserInfoViewModel *)viewModel;

+ (instancetype)instanceWithView:(UIView<BYUserInfoViewProtocol> *)view viewModel:(id<BYUserInfoViewModelProtocol>)viewModel;
- (UIView<BYUserInfoViewProtocol> *)view;
- (id<BYUserInfoViewModelProtocol>)viewModel;

- (void)fetchData;
- (void)setOnClickIconCommand:(RACCommand *)onClickIconCommand;
@end
