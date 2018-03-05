//
//  BYMVPUserViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/2.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYMVPUserViewController.h"
#import "BYBlogViewController.h"
#import "BYUserInfoViewController.h"
#import "BYDetailViewController.h"
#import "BYDraftViewController.h"

@interface BYMVPUserViewController ()<BYBlogViewControllerCallBack>
@property (nonatomic, assign) NSUInteger    userId;
@property (nonatomic, strong) UIButton  *blogButton;
@property (nonatomic, strong) UIButton  *draftButton;
@property (nonatomic, strong) UIScrollView  *scrollView;

@property (nonatomic, strong) BYBlogViewController  *blogVC;
@property (nonatomic, strong) BYUserInfoViewController  *userInfoVC;
@property (nonatomic, strong) BYDraftViewController *draftVC;
@end

@implementation BYMVPUserViewController
+ (instancetype)instancetypeWithUserId:(NSUInteger)userId {
    return [[BYMVPUserViewController alloc] initWithUserId:userId];
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

- (void)blogViewControllerDidSelectBlog:(BYBlog *)blog {
    [self.navigationController pushViewController:[BYBlogDetailViewController instanceWithBlog:blog] animated:YES];
}

- (void)switchTableView:(UIButton *)button {
    if (button == self.blogButton) {
        [self.scrollView setContentOffset:CGPointZero animated:YES];
        self.draftButton.selected = NO;
    }
    else {
        self.blogButton.selected = NO;
        [self.scrollView setContentOffset:CGPointMake(BYSCREEN_WIDTH, 0) animated:YES];
    }
    button.selected = YES;
}

- (void)configuration {
    self.title = [NSString stringWithFormat:@"用户%ld", self.userId];
    
    //因为MVP中的PV关系理论上是多对多的, 所以P层通常都是由MVP的上层直接分配而不是在C层默认创建, 这样在逻辑变动布局不变的情况下, 上层只需要分配一个新的P层就行了, 同理, 如果逻辑不变布局变了, 上层就替换V层即可.
    //更标准的写法是针对每个M都有对应V,C,P, V负责布局 ,C负责和上层交互(某个业务场景的具体需求, 比如HUD), P负责业务逻辑(各种格式化, 各种命令), 但这里因为我偷懒没有建立DraftView而是将TableViewDataSource布局直接写在C层了, 所以此时的DraftViewController即是C也是V.
    
    __weak typeof(self) weakSelf = self;
    
    self.blogVC = [BYBlogViewController instancetypeWithPresenter:[BYBlogViewPresenter presenterWithUserId:self.userId]];
    self.blogVC.delegate = self;
    
    self.draftVC = [BYDraftViewController instanceWithPresenter:[BYDraftViewControllerPresenter presenterWithUserId:self.userId]];
    [self.draftVC setDidSelectedRowHandler:^(BYDraft *draft) {
        [weakSelf.navigationController pushViewController:[BYDraftDetailViewController instanceWithDraft:draft] animated:YES];
    }];
    
    self.userInfoVC = [BYUserInfoViewController instancetypeWithUserId:self.userId];
    [self.userInfoVC setVCGenerator:^UIViewController *(id params) {
        return [BYUserDetailViewController instanceWithUser:params];
    }];
    [self addChildViewController:self.userInfoVC];
}

- (void)addUI {
    CGFloat userInfoViewHeight = [BYUserInfoViewController viewHeight];
    self.userInfoVC.view.frame = CGRectMake(0, 0, BYSCREEN_WIDTH, userInfoViewHeight);
    [self.view addSubview:self.userInfoVC.view];
    
    UIButton *(^makeButton)(NSString *, CGRect) = ^(NSString *title, CGRect frame) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(switchTableView:) forControlEvents:UIControlEventTouchUpInside];
        return button;
    };
    
    CGFloat switchButtonTop = self.userInfoVC.view.bottom;
    CGFloat switchButtonHeight = 40;
    [self.view addSubview:self.blogButton = makeButton(@"博客", CGRectMake(0, switchButtonTop, BYSCREEN_WIDTH * 0.5, switchButtonHeight))];
    [self.view addSubview:self.draftButton = makeButton(@"草稿", CGRectMake(BYSCREEN_WIDTH * 0.5, switchButtonTop, BYSCREEN_WIDTH * 0.5, switchButtonHeight))];
    self.blogButton.selected = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.blogButton.bottom, BYSCREEN_WIDTH, BYSCREEN_HEIGHT - self.blogButton.bottom)];
    scrollView.contentSize = CGSizeMake(BYSCREEN_WIDTH * 2, 0);
    scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView = scrollView];
    
    self.blogVC.tableView.frame = CGRectMake(0, 0, BYSCREEN_WIDTH, scrollView.height);
    [self.scrollView addSubview:self.blogVC.tableView];
    
    self.draftVC.tableView.frame = CGRectMake(BYSCREEN_WIDTH, 0, BYSCREEN_WIDTH, scrollView.height);
    [self.scrollView addSubview:self.draftVC.tableView];
}

- (void)fetchData {
    [self.userInfoVC fetchData];
    [self.blogVC.presenter fetchDataWithCompletionHandler:^(NSError *error, id result) {
        
    }];
    
    [self.draftVC fetchDataWithCompletionHandler:^(NSError *error, id result) {
        
    }];
}

@end
