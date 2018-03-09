//
//  BYContact+CoreDataClass.h
//  VIPERTest
//
//  Created by by_r on 2018/3/6.
//  Copyright © 2018年 by_r. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYContact : NSManagedObject
@property (nonatomic, copy) NSString *fullName;
@end

NS_ASSUME_NONNULL_END

#import "BYContact+CoreDataProperties.h"
