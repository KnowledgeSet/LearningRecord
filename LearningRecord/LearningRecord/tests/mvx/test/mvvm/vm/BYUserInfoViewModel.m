//
//  BYUserInfoViewModel.m
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYUserInfoViewModel.h"
#import "BYUserAPIManager.h"
#import "BYUser.h"

@interface BYUserInfoViewModel ()
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *blogCount;
@property (nonatomic, copy) NSString *friendCount;

@property (nonatomic, strong) BYUser    *user;
@property (nonatomic, assign) NSUInteger    userId;
@end

@implementation BYUserInfoViewModel
+ (instancetype)viewModelWithUserId:(NSUInteger)userId {
    BYUserInfoViewModel *viewModel = [BYUserInfoViewModel new];
    viewModel.userId = userId;
    return viewModel;
}

- (RACCommand *)fetchUserInfoCommand {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [[self fetchUserInfoSignal] doNext:^(BYUser * _Nullable user) {
            self.user = user;
            self.icon = [UIImage imageNamed:user.icon ?: @"130.jpeg"];
            self.name = user.name.length ? user.name : @"匿名";
            self.summary = [NSString stringWithFormat:@"个人简介: %@", user.summary.length > 0 ? user.summary : @"这个人很懒, 什么也没有写~"];
            self.blogCount = [NSString stringWithFormat:@"作品: %ld", user.blogCount];
            self.friendCount = [NSString stringWithFormat:@"好友: %ld", user.friendCount];
        }];
    }];
}

- (RACSignal *)fetchUserInfoSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[BYUserAPIManager new] fetchUserInfoWithUserId:self.userId completionHandler:^(NSError *error, id result) {
            if (!error) {
                [subscriber sendNext:result];
                [subscriber sendCompleted];
            }
            else {
                [subscriber sendError:error];
            }
        }];
        return nil;
    }];
}
@end
