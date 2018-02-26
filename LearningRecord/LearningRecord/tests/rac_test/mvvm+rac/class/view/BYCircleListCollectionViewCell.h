//
//  BYCircleListCollectionViewCell.h
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseCollectionViewCell.h"
#import "BYCircleListCollectionViewCellViewModel.h"

@interface BYCircleListCollectionViewCell : BYRACBaseCollectionViewCell
@property (nonatomic, strong) BYCircleListCollectionViewCellViewModel   *viewModel;
@property (nonatomic, strong) NSString *type;
@end
