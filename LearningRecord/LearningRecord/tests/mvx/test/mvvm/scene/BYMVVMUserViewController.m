//
//  BYMVVMUserViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYMVVMUserViewController.h"
#import "BYDetailViewController.h"
#import "BYUserInfoController.h"
#import "BYUserInfoViewController.h"
#import "BYBlogView.h"

@interface BYMVVMUserViewController ()
@property (nonatomic, assign) NSUInteger    userId;

@property (nonatomic, strong) BYUserInfoController *userInfoController;
@property (nonatomic, strong) BYBlogView    *blogVC;
@end

@implementation BYMVVMUserViewController

+ (instancetype)instancetypeWithUserId:(NSUInteger)userId {
    return [[BYMVVMUserViewController alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configuration];
    [self addUI];
    [self fetchData];
}

- (void)routerEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:LikeBlogEvent]) {
        BYBlogCellViewModel *viewModel = userInfo[kCellViewModel];
        if (!viewModel.isLiked) {
            [[viewModel.likeBlogCommand execute:nil] subscribeError:^(NSError * _Nullable error) {
                NSLog(@"%@", error.domain);
            }];
        }
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:@"确定取消点赞吗?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [[viewModel.likeBlogCommand execute:nil] subscribeError:^(NSError * _Nullable error) {
                                                                 NSLog(@"%@", error.domain);
                                                             }];
                                                         }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                             style:UIAlertActionStyleCancel
                                                           handler:nil];
            [alert addAction:sure];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:NULL];
        }
    }
}

- (void)configuration {
    self.title = @"MVVM";
    self.view.backgroundColor = [UIColor whiteColor];
    
    @weakify(self);
    self.userInfoController = [BYUserInfoController instanceWithView:[BYUserInfoView new] viewModel:[BYUserInfoViewModel viewModelWithUserId:self.userId]];
    [self.userInfoController setOnClickIconCommand:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable user) {
        @strongify(self);
        [self.navigationController pushViewController:[BYUserDetailViewController instanceWithUser:user] animated:YES];
        return [RACSignal empty];
    }]];
    
    self.blogVC = [BYBlogView instanceWithViewModel:[BYBlogViewModel viewModelWithUserId:self.userId]];
    [self.blogVC setDidSelectedRowCommand:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable blog) {
        @strongify(self);
        [self.navigationController pushViewController:[BYBlogDetailViewController instanceWithBlog:blog] animated:YES];
        return [RACSignal empty];
    }]];
}

- (void)addUI {
    CGFloat userInfoViewHeight = [BYUserInfoViewController viewHeight] - self.navigationController.navigationBar.bottom;
    
    self.userInfoController.view.frame = CGRectMake(0, self.navigationController.navigationBar.bottom, BYSCREEN_WIDTH, userInfoViewHeight);
    [self.view addSubview:self.userInfoController.view];
    
    self.blogVC.tableView.frame = CGRectMake(0, self.userInfoController.view.bottom, BYSCREEN_WIDTH, BYSCREEN_HEIGHT - self.userInfoController.view.bottom);
    [self.view addSubview:self.blogVC.tableView];
}

- (void)fetchData {
    [self.userInfoController fetchData]; //或者直接 [[self.userInfoController.viewModel fetchUserInfoCommand] execute:nil];
    
    [[self.blogVC.fetchDataCommand execute:nil] subscribeError:^(NSError * _Nullable error) {
        // hide hud
        NSLog(@"%@", error.domain);
    } completed:^{
       // hide hud
    }];
}

@end
