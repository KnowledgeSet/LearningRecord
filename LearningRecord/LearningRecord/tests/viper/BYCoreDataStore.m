//
//  BYCoreDataStore.m
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYCoreDataStore.h"
#import "BYAppDelegate.h"

@implementation BYCoreDataStore
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    return !self.appdelegate ? nil : self.appdelegate.persistentContainer;
}

+ (NSManagedObjectModel *)managedObjectModel {
    return !self.appdelegate ? nil : self.appdelegate.managedObject;
}

+ (NSManagedObjectContext *)managedObjectContext {
    return !self.appdelegate ? nil : self.appdelegate.managedObjectContext;
}

+ (BYAppDelegate *)appdelegate {
    BYAppDelegate *delegate = nil;
    if ([UIApplication sharedApplication].delegate) {
        delegate = (BYAppDelegate *)([UIApplication sharedApplication].delegate);
    }
    return delegate;
}
@end
