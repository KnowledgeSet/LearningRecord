//
//  BYContactListView.m
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYContactListView.h"
#import "NSArray+BYContactArray.h"

@interface BYContactListView ()
@property (nonatomic, strong) NSMutableArray<BYContactViewModel *> *contactList;
@end

@implementation BYContactListView
@synthesize presenter = _presenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.presenter respondsToSelector:@selector(viewDidLoad)]) {
        [self.presenter viewDidLoad];
    }
    self.tableView.tableFooterView = [UIView new];
}

- (IBAction)didClickOnAddButton:(UIBarButtonItem *)sender {
    if ([self.presenter respondsToSelector:@selector(addNewContactFromView:)]) {
        [self.presenter addNewContactFromView:self];
    }
}

#pragma mark - BYContactListViewProtocol
- (void)reloadInterfaceWithContacts:(NSArray<BYContactViewModel *> *)contacts {
    self.contactList = [contacts mutableCopy];
    [self.tableView reloadData];
}

- (void)didInsertContact:(BYContactViewModel *)contact {
    NSInteger insertionIndex = [self.contactList insertionIndexOf:contact];
    [self.contactList insertObject:contact atIndex:insertionIndex];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:insertionIndex inSection:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.contactList[indexPath.row].fullName;
    return cell;
}

- (NSMutableArray *)contactList {
    if (!_contactList) {
        _contactList = [NSMutableArray array];
    }
    return _contactList;
}

@end
