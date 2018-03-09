//
//  BYAddContactLocalDataManager.m
//  LearningRecord
//
//  Created by by_r on 2018/3/9.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYAddContactLocalDataManager.h"
#import "BYCoreDataStore.h"

@implementation BYAddContactLocalDataManager
- (BYContact *)createContact:(NSString *)firstName lastName:(NSString *)lastName {
    NSManagedObjectContext *context = [BYCoreDataStore managedObjectContext];
    NSAssert(context != nil, @"context not found");
    
    NSEntityDescription *newContact = [NSEntityDescription entityForName:@"BYContact" inManagedObjectContext:context];
    BYContact *contact = [[BYContact alloc] initWithEntity:newContact insertIntoManagedObjectContext:context];
    contact.firstName = firstName;
    contact.lastName = lastName;
    [context save:nil];
    return contact;
}
@end
