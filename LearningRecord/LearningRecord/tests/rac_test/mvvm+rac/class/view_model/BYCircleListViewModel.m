//
//  BYCircleListViewModel.m
//  LearningRecord
//
//  Created by by_r on 2018/2/26.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYCircleListViewModel.h"
#import "BYCircleListCollectionViewCellViewModel.h"

@interface BYCircleListViewModel ()
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation BYCircleListViewModel
- (void)by_initialize {
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSMutableArray *allArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 8; i ++) {
            BYCircleListCollectionViewCellViewModel *viewModel = [[BYCircleListCollectionViewCellViewModel alloc] init];
            viewModel.headerImageStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
            viewModel.name = @"培训圈子";
            [allArray addObject:viewModel];
        }
        self.headerViewModel.dataArray = allArray;
        
        NSMutableArray *reArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 8; i ++) {
            BYCircleListCollectionViewCellViewModel *viewModel = [[BYCircleListCollectionViewCellViewModel alloc] init];
            viewModel.headerImageStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
            viewModel.name = @"培训圈子";
            viewModel.articleNum = @"222";
            viewModel.peopleNum = @"453";
            viewModel.topicNum = @"4324234";
            viewModel.content = @"奥斯卡撒谎个抗裂砂浆分公司拉开飞机上打开； 金卡戴珊";
            [reArray addObject:viewModel];
        }
        self.dataArray = reArray;
        
        [self.headerViewModel.refreshUISubject sendNext:nil];
        [self.refreshEndSubject sendNext:@(BYRACRefreshStatusFooterMore)];
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在加载");
        }
    }];
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSMutableArray *reArray = [NSMutableArray arrayWithArray:self.dataArray];
        for (NSInteger i = 0; i < 8; i ++) {
            BYCircleListCollectionViewCellViewModel *viewModel = [[BYCircleListCollectionViewCellViewModel alloc] init];
//            viewModel.headerImageStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
            viewModel.name = @"公司都会有";
            viewModel.articleNum = @"25462";
            viewModel.peopleNum = @"4532533";
            viewModel.topicNum = @"4326235344";
            viewModel.content = @"奥斯卡撒谎个抗裂砂浆分公司拉开飞机上打开； 金卡戴珊";
            [reArray addObject:viewModel];
        }
        self.dataArray = reArray;
        [self.refreshEndSubject sendNext:@(BYRACRefreshStatusFooterMore)];
    }];
}

#pragma mark - lazy load
- (RACCommand *)refreshDataCommand {
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.currentPage = 1;
                [self.request POST:@"http://www.baidu.com" parameters:nil success:^(BYRACRequest *request, NSString *responseString) {
                    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    [subscriber sendNext:dict];
                    [subscriber sendCompleted];
                } failure:^(BYRACRequest *request, NSError *error) {
                    NSLog(@"网络连接诶失败");
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}

- (RACCommand *)nextPageCommand {
    if (!_nextPageCommand) {
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.currentPage ++;
                [self.request POST:@"http://www.baidu.com" parameters:nil success:^(BYRACRequest *request, NSString *responseString) {
                    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    [subscriber sendNext:dict];
                    [subscriber sendCompleted];
                } failure:^(BYRACRequest *request, NSError *error) {
                    @strongify(self);
                    self.currentPage --;
                    NSLog(@"网络连接失败");
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _nextPageCommand;
}

- (RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}

- (RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

- (RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

- (BYCircleListHeaderViewModel *)headerViewModel {
    if (!_headerViewModel) {
        _headerViewModel = [[BYCircleListHeaderViewModel alloc] init];
        _headerViewModel.title = @"已加入的圈子";
        _headerViewModel.cellClickSubject = self.cellClickSubject;
    }
    return _headerViewModel;
}

- (BYCircleListSectionHeaderViewModel *)sectionHeaderViewModel {
    if (!_sectionHeaderViewModel) {
        _sectionHeaderViewModel = [[BYCircleListSectionHeaderViewModel alloc] init];
        _sectionHeaderViewModel.title = @"推荐圈子";
    }
    return _sectionHeaderViewModel;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
@end
