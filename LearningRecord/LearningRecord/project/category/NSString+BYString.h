//
//  NSString+BYString.h
//  LearningRecord
//
//  Created by by_r on 2018/2/27.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BYStringType) {
    BYStringTypeNum, ///< 纯数字
    BYStringTypeString
};

@interface NSString (BYString)
- (BYStringType)stringType;
@end
