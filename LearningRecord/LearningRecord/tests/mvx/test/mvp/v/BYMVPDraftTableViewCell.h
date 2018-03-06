//
//  BYMVPDraftTableViewCell.h
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYDraftCellPresenter.h"
@interface BYMVPDraftTableViewCell : UITableViewCell
@property (nonatomic, strong) BYDraftCellPresenter *presenter;
@end
