//
//  BYUserInfoViewController.m
//  LearningRecord
//
//  Created by by_r on 2018/3/1.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYUserInfoViewController.h"

#import "BYUser.h"
#import "BYUserAPIManager.h"

@interface BYUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *blogCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendCountLabel;

@property (nonatomic, strong) BYUser    *user;
@property (nonatomic, assign) NSUInteger    userId;
@property (nonatomic, copy) ViewControllerGenerator VCGenerator;
@end

@implementation BYUserInfoViewController

+ (instancetype)instancetypeWithUserId:(NSUInteger)userId {
    BYUserInfoViewController *vc = [BYUserInfoViewController new];
    vc.userId = userId;
    return vc;
}

+ (CGFloat)viewHeight {
    return 160 + 64;
}

- (void)fetchData {
    [[BYUserAPIManager new] fetchUserInfoWithUserId:self.userId completionHandler:^(NSError *error, BYUser * user) {
        if (!error) {
            self.user = user;
            
            self.nameLabel.text = user.name;
            self.summaryLabel.text = [NSString stringWithFormat:@"个人简介: %@", user.summary];
            self.blogCountLabel.text = [NSString stringWithFormat:@"作品: %ld", user.blogCount];
            self.friendCountLabel.text = [NSString stringWithFormat:@"好友: %ld", user.friendCount];
            [self.iconButton setBackgroundImage:[UIImage imageNamed:user.icon] forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)onClickIconButton:(UIButton *)sender {
    if (self.VCGenerator) {
        UIViewController *targetVC = self.VCGenerator(self.user);
        if (targetVC) {
            [self.parentViewController.navigationController pushViewController:targetVC animated:YES];
        }
    }
}

@end
