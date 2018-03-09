//
//  AppDelegate.m
//  LearningRecord
//
//  Created by by_r on 2018/2/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYAppDelegate.h"

@interface BYAppDelegate ()

@end

@implementation BYAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@", NSHomeDirectory());
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - core data stack
@synthesize persistentContainer = _persistentContainer;

- (void)saveContext {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (NSManagedObjectModel *)managedObject {
    if (!_managedObject) {
        _managedObject = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"BYVIPER_Contacts" withExtension:@"momd"]];
    }
    return _managedObject;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentContainer;
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentContainer {
    @synchronized(self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObject];
            NSURL *sqliteURL = [[self documentDirectoryURL] URLByAppendingPathComponent:@"BYContact.sqlite"];
            NSError *error = nil;
            [_persistentContainer addPersistentStoreWithType:NSSQLiteStoreType
                                               configuration:nil
                                                         URL:sqliteURL
                                                     options:nil
                                                       error:&error];
            if (error) {
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                abort();
            }
        }
    }
    return _persistentContainer;
}

- (NSURL *)documentDirectoryURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

@end
