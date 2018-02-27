//
//  NSString+BYString.m
//  LearningRecord
//
//  Created by by_r on 2018/2/27.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "NSString+BYString.h"

@implementation NSString (BYString)
- (BYStringType)stringType {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    float valF;
    BOOL valRet = [scan scanInt:&val] && [scan isAtEnd];
    BOOL valFRet = [scan scanFloat:&valF] && [scan isAtEnd];
    if (valRet || valFRet) {
        return BYStringTypeNum;
    }
    return BYStringTypeString;
}
@end
