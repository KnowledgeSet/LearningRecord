//
//  BYContact+CoreDataProperties.m
//  LearningRecord
//
//  Created by by_r on 2018/3/6.
//  Copyright © 2018年 by_r. All rights reserved.
//
//

#import "BYContact+CoreDataProperties.h"

@implementation BYContact (CoreDataProperties)

+ (NSFetchRequest<BYContact *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BYContact"];
}

@dynamic firstName;
@dynamic lastName;

@end
