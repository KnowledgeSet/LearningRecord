//
//  BYRACBaseTableViewCell.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACBaseTableViewCell.h"

@implementation BYRACBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self by_setupViews];
        [self by_bindViewModel];
    }
    return self;
}

- (void)by_setupViews {}
- (void)by_bindViewModel {}

@end
