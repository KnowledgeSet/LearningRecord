//
//  BYRACLoginViewModel.h
//  LearningRecord
//
//  Created by by_r on 2018/2/24.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface BYRACLoginViewModel : NSObject
@property (nonatomic, copy) NSString    *account;
@property (nonatomic, copy) NSString    *password;
@property (nonatomic, strong)RACSignal  *btnEnableSignal;
@property (nonatomic, strong) RACCommand    *loginCommand;
@end
