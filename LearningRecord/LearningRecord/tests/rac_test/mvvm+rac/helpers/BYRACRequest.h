//
//  BYRACRequest.h
//  LearningRecord
//
//  Created by by_r on 2018/2/24.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface BYRACRequest : NSObject
@property (nonatomic, strong) AFHTTPSessionManager  *operationManager;
@property (nonatomic, strong) NSOperationQueue  *operationQueue;
+ (instancetype)request;

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void(^)(BYRACRequest *request, NSString *responseString))success
     failure:(void(^)(BYRACRequest *request, NSError *error))failure;
- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(void(^)(BYRACRequest *request, NSString *responseString))success
    failure:(void(^)(BYRACRequest *request, NSError *error))failure;
- (void)GET:(NSString *)URLString;
- (void)cancelAllOperations;
@end
