//
//  BYMVPDraftTableViewCell.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYMVPDraftTableViewCell.h"

@interface BYMVPDraftTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *editDataLabel;
@end

@implementation BYMVPDraftTableViewCell

- (void)setPresenter:(BYDraftCellPresenter *)presenter {
    _presenter = presenter;
    self.titleLabel.text = presenter.draftTitleText;
    self.summaryLabel.text = presenter.draftSummaryText;
    self.editDataLabel.text = presenter.draftEditDateText;
}

@end
