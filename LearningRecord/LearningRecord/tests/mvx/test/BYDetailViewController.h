//
//  BYDetailViewController.h
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBaseViewController.h"

@class BYUser;
@class BYBlog;
@class BYDraft;
@interface BYUserDetailViewController : BYBaseViewController
+ (instancetype)instanceWithUser:(BYUser *)user;
@end

@interface BYBlogDetailViewController : BYBaseViewController
+ (instancetype)instanceWithBlog:(BYBlog *)blog;
@end

@interface BYDraftDetailViewController : BYBaseViewController
+ (instancetype)instanceWithDraft:(BYDraft *)draft;
@end
