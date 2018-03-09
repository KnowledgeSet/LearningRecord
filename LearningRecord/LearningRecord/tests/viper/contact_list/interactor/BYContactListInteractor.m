//
//  BYContactListInteractor.m
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYContactListInteractor.h"

@implementation BYContactListInteractor
@synthesize presenter, localDatamanager;
- (void)retrieveContacts {
    BOOL response = [self.localDatamanager respondsToSelector:@selector(retrieveContactList)];
    if (response) {
        // 获取数据
        NSArray *contactList = [self.localDatamanager retrieveContactList];
        if ([self.presenter respondsToSelector:@selector(didRetrieveContacts:)]) {
            // 调用代理
            [self.presenter didRetrieveContacts:contactList ?: @[]];
        }
    }
}

@end
