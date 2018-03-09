//
//  BYContactListProtocols.h
//  LearningRecord
//
//  Created by by_r on 2018/3/6.
//  Copyright © 2018年 by_r. All rights reserved.
//

#ifndef BYContactListProtocols_h
#define BYContactListProtocols_h
#import <UIKit/UIKit.h>

#import "BYContact+CoreDataProperties.h"
#import "BYContactViewModel.h"

@protocol BYContactListViewProtocol;
@protocol BYContactListPresenterProtocol;
@protocol BYContactListInteractorOutputProtocol;
@protocol BYContactListLocalDataManagerInputProtocol;
#pragma mark - PRESENTER OUTPUT
/// PRESENTER -> VIEW
@protocol BYContactListViewProtocol <NSObject>
@property(nonatomic, strong) id<BYContactListPresenterProtocol> presenter;
- (void)didInsertContact:(BYContactViewModel *)contact;
- (void)reloadInterfaceWithContacts:(NSArray<BYContactViewModel *> *)contacts;
@end
/// PRESENTER -> ROUTER
@protocol BYContactListRouterProtocol <NSObject>
+ (UIViewController *)createContactListModule;
- (void)presentAddContactScreenFromView:(id<BYContactListViewProtocol>)view;
@end
/// PRESENTER -> INTERACTOR
@protocol BYContactListInteractorInputProtocol <NSObject>
@property(nonatomic, strong) id<BYContactListInteractorOutputProtocol> presenter;
@property(nonatomic, strong) id<BYContactListLocalDataManagerInputProtocol> localDatamanager;
- (void)retrieveContacts;
@end

#pragma mark - INTERACTOR OUTPUT
/// INTERACTOR -> PRESENTER
@protocol BYContactListInteractorOutputProtocol <NSObject>
- (void)didRetrieveContacts:(NSArray<BYContact *> *)contacts;
@end
/// INTERACTOR -> LOCALDATAMANAGER
@protocol BYContactListLocalDataManagerInputProtocol <NSObject>
/// 从数据库读取数据
- (NSArray<BYContact *> *)retrieveContactList;
@end

#pragma mark - VIEW OUTPUT
/// VIEW -> PRESENTER
@protocol BYContactListPresenterProtocol <NSObject>
@property(nonatomic, weak) id<BYContactListViewProtocol> view; ///< 此处弱引用
@property(nonatomic, strong) id<BYContactListInteractorInputProtocol> interactor;
@property(nonatomic, strong) id<BYContactListRouterProtocol> router;
- (void)viewDidLoad;
- (void)addNewContactFromView:(id<BYContactListViewProtocol>)view;
@end

#endif /* BYContactListProtocols_h */
