//
//  AppDelegate.h
//  LearningRecord
//
//  Created by by_r on 2018/2/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface BYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) NSManagedObjectModel *managedObject;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong) NSPersistentStoreCoordinator *persistentContainer;

- (void)saveContext;

- (void)testSwizzling;

@end

