//
//  BYContactListPresenter.m
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYContactListPresenter.h"
#import "BYContact+BYFullName.h"

@implementation BYContactListPresenter
@synthesize view, interactor, router;

- (void)viewDidLoad {
    if ([self.interactor respondsToSelector:@selector(retrieveContacts)]) {
        [self.interactor retrieveContacts];
    }
}

- (void)addNewContactFromView:(id<BYContactListViewProtocol>)view {
    if ([self.router respondsToSelector:@selector(presentAddContactScreenFromView:)]) {
        [self.router presentAddContactScreenFromView:view];
    }
}

- (void)didRetrieveContacts:(NSArray<BYContact *> *)contacts {
    if ([self.view respondsToSelector:@selector(reloadInterfaceWithContacts:)]) {
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:contacts.count];
        for (BYContact *contact in contacts) {
            [tmp addObject:[[BYContactViewModel alloc] initWithFullName:contact.fullName]];
        }
        [self.view reloadInterfaceWithContacts:tmp];
    }
}

- (void)didAddContact:(BYContact *)contact {
    BYContactViewModel *contactViewModel = [[BYContactViewModel alloc] initWithFullName:contact.fullName];
    if ([self.view respondsToSelector:@selector(didInsertContact:)]) {
        [self.view didInsertContact:contactViewModel];
    }
}

- (void)didCancelAddContact {}
@end
