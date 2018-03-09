//
//  BYContactListLocalDataManager.m
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYContactListLocalDataManager.h"
#import "BYCoreDataStore.h"

@implementation BYContactListLocalDataManager
- (NSArray<BYContact *> *)retrieveContactList {
    NSManagedObjectContext *context = [BYCoreDataStore managedObjectContext];
    NSAssert(context != nil, @"context not found");
    
    NSFetchRequest<BYContact *> *request = [NSFetchRequest fetchRequestWithEntityName:@"BYContact"];
    SEL caseInsensitiveSelector = @selector(caseInsensitiveCompare:);
    NSSortDescriptor *sortDescriptorFirstName = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES selector:caseInsensitiveSelector];
    NSSortDescriptor *sortDescriptorLastName = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES selector:caseInsensitiveSelector];
    request.sortDescriptors = @[sortDescriptorFirstName, sortDescriptorLastName];
    return [context executeFetchRequest:request error:NULL];
}
@end
