//
//  BYRACBaseCollectionViewCell.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseCollectionViewCell.h"

@implementation BYRACBaseCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self by_setupViews];
    }
    return self;
}

- (void)by_setupViews {}
@end
