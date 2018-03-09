//
//  BYAddContactInteractor.m
//  LearningRecord
//
//  Created by by_r on 2018/3/9.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYAddContactInteractor.h"

@implementation BYAddContactInteractor
@synthesize presenter, localDatamanager;

- (BYContact *)saveNewContact:(NSString *)firstName lastName:(NSString *)lastName {
    @try {
        BYContact *contact = nil;
        if ([self.localDatamanager respondsToSelector:@selector(createContact:lastName:)]) {
            contact = [self.localDatamanager createContact:firstName lastName:lastName];
        }
        return contact;
    } @catch (NSException *exception) {
        return nil;
    } @finally {
        
    }
}

@end
