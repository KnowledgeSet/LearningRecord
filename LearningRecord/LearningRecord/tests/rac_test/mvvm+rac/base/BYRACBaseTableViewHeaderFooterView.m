//
//  BYRACBaseTableViewHeaderFooterView.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseTableViewHeaderFooterView.h"

@implementation BYRACBaseTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self by_setupViews];
    }
    return self;
}

- (void)by_setupViews {}

@end
