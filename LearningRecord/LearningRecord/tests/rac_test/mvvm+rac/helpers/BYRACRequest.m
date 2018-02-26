//
//  BYRACRequest.m
//  LearningRecord
//
//  Created by by_r on 2018/2/24.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYRACRequest.h"

@implementation BYRACRequest
+ (instancetype)request {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.operationManager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(BYRACRequest *, NSString *))success failure:(void (^)(BYRACRequest *, NSError *))failure {
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.operationManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress: %@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"[Request]: %@", responseJson);
        !success ?: success(self, responseJson);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[Request]: %@", error.description);
        !failure ?: failure(self, error);
    }];
}

- (void)GET:(NSString *)URLString {
    [self GET:URLString parameters:nil success:nil failure:nil];
}

- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(BYRACRequest *, NSString *))success failure:(void (^)(BYRACRequest *, NSError *))failure {
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.operationManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress: %@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"[Request]: %@", responseJson);
        !success ?: success(self, responseJson);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[Request]: %@", error.description);
        !failure ?: failure(self, error);
    }];
}

- (void)cancelAllOperations {
    [self.operationQueue cancelAllOperations];
}
@end
