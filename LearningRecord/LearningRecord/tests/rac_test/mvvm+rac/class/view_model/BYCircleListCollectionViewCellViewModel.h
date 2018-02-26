//
//  BYCircleListCollectionViewCellViewModel.h
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseViewModel.h"

@interface BYCircleListCollectionViewCellViewModel : BYRACBaseViewModel
@property (nonatomic, copy) NSString    *headerImageStr;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *articleNum;
@property (nonatomic, copy) NSString    *peopleNum;
@property (nonatomic, copy) NSString    *topicNum;
@property (nonatomic, copy) NSString    *content;
@end
