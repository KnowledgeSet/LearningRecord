//
//  BYAddContactView.m
//  LearningRecord
//
//  Created by by_r on 2018/3/9.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYAddContactView.h"


@interface BYAddContactView ()
@property (nonatomic, weak) IBOutlet UITextField    *firstNameTextField;
@property (nonatomic, weak) IBOutlet UITextField    *lastNameTextField;
@end

@implementation BYAddContactView
@synthesize presenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.firstNameTextField becomeFirstResponder];
}

- (IBAction)didClickOnDoneButton:(UIBarButtonItem *)sender {
    if (!self.firstNameTextField.text.length || !self.lastNameTextField.text.length) {
        [self showEmptyNameAlert];
        return;
    }
    if ([self.presenter respondsToSelector:@selector(addNewContact:lastName:)]) {
        [self.presenter addNewContact:self.firstNameTextField.text lastName:self.lastNameTextField.text];
    }
}

- (IBAction)didClickOnCancelButton:(UIBarButtonItem *)sender {
    if ([self.presenter respondsToSelector:@selector(cancelAddContactAction)]) {
        [self.presenter cancelAddContactAction];
    }
}

- (void)showEmptyNameAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"A contact must have first and last names" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
