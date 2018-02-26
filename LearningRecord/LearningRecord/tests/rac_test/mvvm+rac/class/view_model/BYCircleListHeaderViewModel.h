//
//  BYCircleListHeaderViewModel.h
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseViewModel.h"
#import "BYRACHeaders.h"

@interface BYCircleListHeaderViewModel : BYRACBaseViewModel
@property (nonatomic, strong) RACSubject    *refreshUISubject;
@property (nonatomic, strong) RACSubject    *cellClickSubject;
@property (nonatomic, copy) NSString    *title;
@property (nonatomic, strong) NSArray   *dataArray;
@end
