//
//  BYVIPERVC.m
//  LearningRecord
//
//  Created by by_r on 2018/3/6.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYVIPERVC.h"
#import "BYContactListRouter.h"

@interface BYVIPERVC ()

@end

@implementation BYVIPERVC

- (void)viewDidLoad {
    self.dataArray = @[NSStringFromSelector(@selector(testContactListWithVIPER))];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)testContactListWithVIPER {
    UIViewController *contactlist = [BYContactListRouter createContactListModule];
//    UIViewController *vc = [[UIStoryboard storyboardWithName:@"BYVIPER" bundle:nil] instantiateViewControllerWithIdentifier:@"contactListView"];
    [self.navigationController pushViewController:contactlist animated:YES];
}

@end
