//
//  BYAddContactProtocols.h
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#ifndef BYAddContactProtocols_h
#define BYAddContactProtocols_h
#import <UIKit/UIKit.h>
#import "BYContact+BYFullName.h"

@protocol BYAddContactPresenterProtocol;
@protocol BYAddContactInteractorOutputProtocol;
@protocol BYAddContactLocalDataManagerInputProtocol;
/// ContactListPresenter <---> AddContactPresenter
@protocol BYAddModuleDelegate <NSObject>
- (void)didAddContact:(BYContact *)contact;
- (void)didCancelAddContact;
@end

#pragma mark - PRESENTER OUTPUT
/// PRESENTER -> VIEW
@protocol BYAddContactViewProtocol <NSObject>
@property (nonatomic, strong) id<BYAddContactPresenterProtocol> presenter;
@end

/// PRESENTER -> ROUTER
@protocol BYAddContactRouterProtocol <NSObject>
+ (UIViewController *)createAddContactModule:(id<BYAddModuleDelegate>)delegate;
- (void)dismissAddContactInterfaceFromView:(id<BYAddContactViewProtocol>)view completion:(void(^)(void))compltion;
@end

/// PRESENTER -> INTERACTOR
@protocol BYAddContactInteractorInputProtocol <NSObject>
@property (nonatomic, strong) id<BYAddContactInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id<BYAddContactLocalDataManagerInputProtocol> localDatamanager;
- (BYContact *)saveNewContact:(NSString *)firstName lastName:(NSString *)lastName;
@end

#pragma mark - INTERACTOR OUTPUT
/// INTERACTOR -> PRESENTER
@protocol BYAddContactInteractorOutputProtocol <NSObject>

@end

/// INTERACTOR -> LOCALDATAMANGER
@protocol BYAddContactLocalDataManagerInputProtocol <NSObject>
- (BYContact *)createContact:(NSString *)firstName lastName:(NSString *)lastName;
@end

#pragma mark - VIEW OUTPUT
/// VIEW -> PRESENTER
@protocol BYAddContactPresenterProtocol <NSObject>
@property (nonatomic, weak) id<BYAddContactViewProtocol> view; /// 此处弱引用
@property (nonatomic, strong) id<BYAddContactInteractorInputProtocol> interactor;
@property (nonatomic, strong) id<BYAddContactRouterProtocol> router;
@property (nonatomic, strong) id<BYAddModuleDelegate> delegate;
- (void)cancelAddContactAction;
- (void)addNewContact:(NSString *)firstName lastName:(NSString *)lastName;
@end

#endif /* BYAddContactProtocols_h */
