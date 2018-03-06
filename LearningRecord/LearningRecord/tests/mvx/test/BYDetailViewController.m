//
//  BYDetailViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYDetailViewController.h"
#import "BYUser.h"
#import "BYBlog.h"
#import "BYDraft.h"
#import "BYSceneY.h"
@implementation BYUserDetailViewController

+ (instancetype)instanceWithUser:(BYUser *)user {
    return [[BYUserDetailViewController alloc] initWithWithUser:user];
}

- (instancetype)initWithWithUser:(BYUser *)user {
    if (self = [super init]) {
        
        self.title = user.name;
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end

@implementation BYBlogDetailViewController
+ (instancetype)instanceWithBlog:(BYBlog *)blog {
    return [[BYBlogDetailViewController alloc] initWithBlog:blog];
}

- (instancetype)initWithBlog:(BYBlog *)blog {
    if (self = [super init]) {
        self.title = blog.blogTitle;
    }
    return self;
}
@end

@implementation BYDraftDetailViewController
+ (instancetype)instanceWithDraft:(BYDraft *)draft {
    return [[BYDraftDetailViewController alloc] initWithDraft:draft];
}

- (instancetype)initWithDraft:(BYDraft *)draft {
    if (self = [super init]) {
        self.title = draft.draftTitle;
        self.view.backgroundColor = [UIColor blueColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, BYSCREEN_WIDTH, 50)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"SceneY" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toSceneY) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    return self;
}

- (void)toSceneY {
    [self.navigationController pushViewController:[BYSceneY new] animated:YES];
}
@end
