//
//  BYRACViewProtocol.h
//  LearningRecord
//
//  Created by by_r on 2018/2/24.
//  Copyright © 2018年 by_r. All rights reserved.
//

#ifndef BYRACViewProtocol_h
#define BYRACViewProtocol_h

#import <Foundation/Foundation.h>

@protocol BYRACViewModelProtocol;
@protocol BYRACViewProtocol <NSObject>
@optional
- (instancetype)initWithViewModel:(id<BYRACViewModelProtocol>)viewModel;
- (void)by_bindViewModel;
- (void)by_setupViews;
- (void)by_addReturnKeyboard;
@end

#endif /* BYRACViewProtocol_h */
