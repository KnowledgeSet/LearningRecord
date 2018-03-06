//
//  BYUserInfoViewModel.h
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYMVXHeader.h"

@class BYUser;
@protocol BYUserInfoViewModelProtocol <NSObject>
- (BYUser *)user;
- (RACCommand *)fetchUserInfoCommand;
- (UIImage *)icon;
- (NSString *)name;
- (NSString *)summary;
- (NSString *)blogCount;
- (NSString *)friendCount;
@end

@interface BYUserInfoViewModel : NSObject<BYUserInfoViewModelProtocol>
+ (instancetype)viewModelWithUserId:(NSUInteger)userId;
@end
