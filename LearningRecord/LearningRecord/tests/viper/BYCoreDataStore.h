//
//  BYCoreDataStore.h
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSUInteger, BYPersistenceError) {
    managedObjectContextNotFound,
    couldNotCreateObject,
    objectNotFound,
};

@interface BYCoreDataStore : NSObject
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
+ (NSManagedObjectModel *)managedObjectModel;
+ (NSManagedObjectContext *)managedObjectContext;
@end
