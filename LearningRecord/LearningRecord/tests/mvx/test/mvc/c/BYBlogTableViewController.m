//
//  BYBlogTableViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYBlogTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "BYBlogTableViewCell.h"
#import "BYBlogCellHelper.h"


#define RowHeight 44
#define ReuseIdentifier @"BYBlogTableViewCell"

@interface BYBlogTableViewController ()
@property (nonatomic, copy) ViewControllerGenerator VCGenerator;
@property (nonatomic, assign) NSUInteger    userId;
@property (nonatomic, strong) BYUserAPIManager  *apiManager;

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSMutableArray<BYBlogCellHelper *>    *blogs;
@end

@implementation BYBlogTableViewController
+ (instancetype)instancetypeWithUserId:(NSUInteger)userId {
    return [[BYBlogTableViewController alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        self.userId = userId;
        self.blogs = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.apiManager = [BYUserAPIManager new];
        [self.tableView registerNib:[UINib nibWithNibName:ReuseIdentifier bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
        
        __weak typeof(self) weakSelf = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.apiManager refreshUserBlogsWithUserId:userId completionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.mj_header endRefreshing];
                if (!error) {
                    [weakSelf.blogs removeAllObjects];
                    [weakSelf reloadTableViewWithBlogs:result];
                    [weakSelf.tableView.mj_footer resetNoMoreData];
                }
            }];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.apiManager loadMoreUserBlogsWithUserId:userId completionHandler:^(NSError *error, id result) {
                [weakSelf.tableView.mj_footer endRefreshing];
                if (!error) {
                    [weakSelf reloadTableViewWithBlogs:result];
                }
                else if (error.code == NetworkErrorNoMoreData) {
                    NSLog(@"%@", error.domain);
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }];
        }];
    }
    return self;
}

- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHander {
    [self.apiManager refreshUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        if (error) {
            //            ... show errorView in tableView
        } else {
            [self reloadTableViewWithBlogs:result];
        }
        
        !completionHander ?: completionHander(error, result);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYBlogCellHelper *cellHelper = self.blogs[indexPath.row];
    BYBlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.title = cellHelper.blogTitleText;
    cell.summary = cellHelper.blogSummaryText;
    cell.likeState = cellHelper.isLiked;
    cell.likeCountText = cellHelper.blogLikeCountText;
    cell.shareCountText = cellHelper.blogShareCountText;
    __weak typeof(&*cell) weakCell = cell;
    [weakCell setDidLikeHandler:^{
        if (cellHelper.blog.isLiked) {
            NSLog(@"已经赞过了");
        }
        else {
            [[BYUserAPIManager new] likeBlogWithBlogId:cellHelper.blog.blogId completionHandler:^(NSError *error, id result) {
                if (error) {
                    NSLog(@"%@", error.domain);
                }
                else {
                    cellHelper.blog.likeCount += 1;
                    weakCell.likeState = cellHelper.blog.isLiked = YES;
                    weakCell.likeCountText = cellHelper.blogLikeCountText;
                }
            }];
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.VCGenerator) {
        UIViewController *targetVC = self.VCGenerator(self.blogs[indexPath.row].blog);
        if (targetVC) {
            [self.tableView.navigationController pushViewController:targetVC animated:YES];
        }
    }
}

- (void)reloadTableViewWithBlogs:(NSArray *)blogs {
    for (BYBlog *blog in blogs) {
        [self.blogs addObject:[BYBlogCellHelper helperWithBlog:blog]];
    }
    [self.tableView reloadData];
}
@end
