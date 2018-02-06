//
//  ViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/2/5.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYViewController.h"

static NSString *const kCls = @"cls";
static NSString *const kDesc = @"desc";

@interface BYViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray   *dataArray;
@end

@implementation BYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    NSString *clsString = [dict objectForKey:kCls];
    if (clsString.length) {
        Class cls = NSClassFromString(clsString);
        if (cls && [cls isKindOfClass:[UIViewController class]]) {
            UIViewController *clsVC = [cls new];
            [self.navigationController pushViewController:clsVC animated:YES];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.textLabel.text = [dict objectForKey:kCls];
    cell.detailTextLabel.text = [dict objectForKey:kDesc];
    return cell;
}

#pragma mark - lazy load
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:
                      @{
                        kCls : @"",
                        kDesc : @"",
                        },
                      @{
                        kCls : @"",
                        kDesc : @""
                        },
                      nil];
    }
    return _dataArray;
}


@end
