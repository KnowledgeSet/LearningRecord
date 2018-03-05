//
//  BYUserInfoView.h
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BYUserInfoViewProtocol <NSObject>
- (UIButton *)iconButton;
- (UILabel *)nameLabel;
- (UILabel *)summaryLabel;
- (UILabel *)blogCountLabel;
- (UILabel *)friendCountLabel;
@end

@interface BYUserInfoView : UIView<BYUserInfoViewProtocol>
//- (UIButton *)iconButton;
//- (UILabel *)nameLabel;
//- (UILabel *)summaryLabel;
//- (UILabel *)blogCountLabel;
//- (UILabel *)friendCountLabel;
@end
