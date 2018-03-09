//
//  BYAddContactPresenter.m
//  LearningRecord
//
//  Created by by_r on 2018/3/9.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYAddContactPresenter.h"

@implementation BYAddContactPresenter
@synthesize view, interactor, router, delegate;

- (void)cancelAddContactAction {
    if (view) {
        if ([self.router respondsToSelector:@selector(dismissAddContactInterfaceFromView:completion:)]) {
            __weak typeof(&*self) weakSelf = self;
            [self.router dismissAddContactInterfaceFromView:view completion:^{
                if ([weakSelf.delegate respondsToSelector:@selector(didCancelAddContact)]) {
                    [weakSelf.delegate didCancelAddContact];
                }
            }];
        }
    }
}

- (void)addNewContact:(NSString *)firstName lastName:(NSString *)lastName {
    if ([self.interactor respondsToSelector:@selector(saveNewContact:lastName:)]) {
        BYContact *contact = [self.interactor saveNewContact:firstName lastName:lastName];
        if (view && contact) {
            if ([self.router respondsToSelector:@selector(dismissAddContactInterfaceFromView:completion:)]) {
                __weak typeof(&*self) weakSelf = self;
                [self.router dismissAddContactInterfaceFromView:view completion:^{
                    if ([weakSelf.delegate respondsToSelector:@selector(didAddContact:)]) {
                        [weakSelf.delegate didAddContact:contact];
                    }
                }];
            }
        }
    }
}

@end
