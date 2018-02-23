//
//  BYTableViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/2/6.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYTableViewController.h"

@interface BYTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong, readwrite) UITableView    *myTableView;
@end

@implementation BYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.myTableView];
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *first = [[[self.dataArray objectAtIndex:indexPath.row] componentsSeparatedByString:@","] firstObject];
    if (first.length) {
        SEL selector = NSSelectorFromString(first);
        if (selector) {
            if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self performSelector:selector];
#pragma clang diagnostic pop
                return;
            }
        }
        Class cls = NSClassFromString(first);
        if (cls) {
            UIViewController *clsVC = [cls new];
            if ([clsVC isKindOfClass:[UIViewController class]]) {
                [self.navigationController pushViewController:clsVC animated:YES];
                return;
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSArray *components = [[self.dataArray objectAtIndex:indexPath.row] componentsSeparatedByString:@","];
    cell.textLabel.text = [components firstObject];
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [components lastObject];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

#pragma mark - lazy load
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tab = [[UITableView alloc] initWithFrame:self.view.bounds];
            tab.dataSource = self;
            tab.delegate = self;
            tab.estimatedRowHeight = 44.0f;
            tab;
        });
    }
    return _myTableView;
}

@end
