//
//  BYMVPBlogTableViewCell.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYBlogCellPresenter.h"

@interface BYMVPBlogTableViewCell : UITableViewCell
@property (nonatomic, strong) BYBlogCellPresenter   *presenter;
- (void)setDidLikeHandler:(void(^)(void))didLikeHandler;
@end
