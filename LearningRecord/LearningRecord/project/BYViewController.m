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

@interface LinkGrammar : NSObject
- (LinkGrammar *(^)(NSString *str, void(^)(NSString *str2)))play;
@end
@implementation LinkGrammar
- (LinkGrammar *(^)(NSString *, void (^)(NSString *)))play {
    return ^(NSString *str, void(^block)(NSString *str2)) {
        !block ?: block(str);
        return self;
    };
}
@end

@interface BYViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray   *dataArray;
@end

@implementation BYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LinkGrammar *link = [[LinkGrammar alloc] init];
    link.play(@"aaa", ^(NSString *str) {
        NSLog(@"%@", str);
    }).play(@"bbb", ^(NSString *str) {
        NSLog(@" %@", str);
    });
    void * obj = (__bridge void *)(link);
    NSLog(@"%@, %@", obj, link);
    
    // 基本类型和对象类型
    __block int a = 0;
    NSLog(@"定义前：%p", &a);         //栈区
    NSMutableString *aa = [NSMutableString stringWithString:@"Tom"];
    NSLog(@"\\n 定以前：------------------------------------\\n\\aa指向的堆中地址：%p；aa在栈中的指针地址：%p", aa, &aa); //a在栈区
    void (^foo)(void) = ^{
        a = 1;
        NSLog(@"block内部：%p", &a);    //堆区
        aa.string = @"Jerry"; // 没有修改指向堆中的地址，而是修改指向堆中的内容
        NSLog(@"\\n block内部：------------------------------------\\n\\aa指向的堆中地址：%p；aa在栈中的指针地址：%p", aa, &aa); //a在栈区
//        aa = [NSMutableString stringWithString:@"William"]; // 没有加__block，此时修改的不是堆中的内容，而是栈中的内容，所以编译不通过
    };
    NSLog(@"定义后：%p", &a);         //堆区
    foo();
    NSLog(@"\\n 定以后：------------------------------------\\n\\aa指向的堆中地址：%p；aa在栈中的指针地址：%p", aa, &aa); //a在栈区
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    NSString *clsString = [dict objectForKey:kCls];
    if (clsString.length) {
        Class cls = NSClassFromString(clsString);
        if (cls) {
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
                        kCls : @"BYDataStructVC",
                        kDesc : @"data struct test",
                        },
                      @{
                        kCls : @"BYRACViewController",
                        kDesc : @"rac test"
                        },
                      @{
                        kCls : @"BYMVXVC",
                        kDesc : @"MVX系列模式"
                        },
                      @{
                        kCls : @"BYVIPERVC",
                        kDesc : @"VIPER模式"
                        },
                      @{
                        kCls : @"BYInterviewVC",
                        kDesc : @"面试题测试"
                        },
                      nil];
    }
    return _dataArray;
}


@end
