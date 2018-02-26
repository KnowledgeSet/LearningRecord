//
//  BYRACViewModelProtocol.h
//  LearningRecord
//
//  Created by by_r on 2018/2/24.
//  Copyright © 2018年 by_r. All rights reserved.
//

#ifndef BYRACViewModelProtocol_h
#define BYRACViewModelProtocol_h

#import <Foundation/Foundation.h>
#import "BYRACRequest.h"

typedef NS_ENUM(NSUInteger, BYRACRefreshStatus) {
    BYRACRefreshStatusHeaderMore = 1,
    BYRACRefreshStatusHeaderNoMore,
    BYRACRefreshStatusFooterMore,
    BYRACRefreshStatusFooterNoMore,
    BYRACRefreshStatusError,
    BYRACRefreshStatusUI
};

@protocol BYRACViewModelProtocol <NSObject>
@optional
- (instancetype)initWithModel:(id)model;
- (void)by_initialize;
@property (nonatomic, strong) BYRACRequest  *request;
@end

#endif /* BYRACViewModelProtocol_h */
