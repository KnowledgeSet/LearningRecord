//
//  NSArray+BYContactArray.h
//  LearningRecord
//
//  Created by by_r on 2018/3/9.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYContactViewModel.h"

@interface NSArray (BYContactArray)
- (NSInteger)insertionIndexOf:(BYContactViewModel *)contact;
@end
