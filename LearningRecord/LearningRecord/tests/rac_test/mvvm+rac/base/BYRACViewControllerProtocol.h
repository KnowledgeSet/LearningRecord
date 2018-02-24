//
//  BYRACViewControllerProtocol.h
//  LearningRecord
//
//  Created by by_r on 2018/2/24.
//  Copyright © 2018年 by_r. All rights reserved.
//

#ifndef BYRACViewControllerProtocol_h
#define BYRACViewControllerProtocol_h

#import <Foundation/Foundation.h>

@protocol BYRACViewModelProtocol;
@protocol BYRACViewControllerProtocol <NSObject>
@optional
- (instancetype)initWithViewModel:(id<BYRACViewModelProtocol>)viewModel;
/// 绑定数据
- (void)by_bindViewModel;
/// 添加UI
- (void)by_addSubviews;
/// 设置导航
- (void)by_layoutNavigation;
/// 请求数据
- (void)by_getNewData;
/// 管理键盘
- (void)recoverKeyboard;
@end

#endif /* BYRACViewControllerProtocol_h */
