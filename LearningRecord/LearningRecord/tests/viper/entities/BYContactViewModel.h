//
//  BYContactViewModel.h
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYContactViewModel : NSObject
@property (nonatomic, copy) NSString *fullName;
- (instancetype)initWithFullName:(NSString *)fullName;
+ (BOOL)granthan:(BYContactViewModel *)lhs rhs:(BYContactViewModel *)rhs;
+ (BOOL)lessthan:(BYContactViewModel *)lhs rhs:(BYContactViewModel *)rhs;
@end
