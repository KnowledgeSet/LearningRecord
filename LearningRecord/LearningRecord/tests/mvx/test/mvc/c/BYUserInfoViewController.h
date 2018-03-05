//
//  BYUserInfoViewController.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBaseViewController.h"
#import "BYMVXHeader.h"
@interface BYUserInfoViewController : BYBaseViewController
+ (instancetype)instancetypeWithUserId:(NSUInteger)userId;
+ (CGFloat)viewHeight;

- (void)fetchData;
- (void)setVCGenerator:(ViewControllerGenerator)VCGenerator;
@end
