//
//  BYCircleListViewModel.h
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseViewModel.h"
#import "BYCircleListSectionHeaderViewModel.h"
#import "BYCircleListHeaderViewModel.h"
#import "BYRACHeaders.h"

@interface BYCircleListViewModel : BYRACBaseViewModel
@property (nonatomic, strong) BYCircleListHeaderViewModel   *headerViewModel;
@property (nonatomic, strong) BYCircleListSectionHeaderViewModel *sectionHeaderViewModel;
@property (nonatomic, strong) RACSubject    *cellClickSubject;
@property (nonatomic, strong) RACCommand    *refreshDataCommand;
@property (nonatomic, strong) RACCommand    *nextPageCommand;
@property (nonatomic, strong) RACSubject    *refreshUI;
@property (nonatomic, strong) RACSubject    *refreshEndSubject;
@property (nonatomic, strong) NSArray   *dataArray;
@end
