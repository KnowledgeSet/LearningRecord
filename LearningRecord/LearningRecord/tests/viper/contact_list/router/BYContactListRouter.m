//
//  BYContactListRouter.m
//  LearningRecord
//
//  Created by by_r on 2018/3/9.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYContactListRouter.h"
#import "BYContactListView.h"
#import "BYContactListPresenter.h"
#import "BYContactListInteractor.h"
#import "BYContactListLocalDataManager.h"
#import "BYAddContactProtocols.h"
#import "BYAddContactRouter.h"

@implementation BYContactListRouter
+ (UIViewController *)createContactListModule {
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"contactListNavigation"];
    if ([navController.childViewControllers.firstObject isKindOfClass:[BYContactListView class]]) {
        BYContactListView *view = (BYContactListView *)(navController.childViewControllers.firstObject);
        id<BYContactListPresenterProtocol, BYContactListInteractorOutputProtocol> presenter = [BYContactListPresenter new];
        id<BYContactListInteractorInputProtocol> interactor = [BYContactListInteractor new];
        id<BYContactListLocalDataManagerInputProtocol> localDataManager = [BYContactListLocalDataManager new];
        id<BYContactListRouterProtocol> router = [BYContactListRouter new];
        
        // 绑定VIPER各层
        view.presenter = presenter;
        presenter.view = view;
        presenter.router = router;
        presenter.interactor = interactor;
        interactor.presenter = presenter;
        interactor.localDatamanager = localDataManager;
        
        return view;
    }
    return [UIViewController new];
}

/// 导航到AddContact界面
- (void)presentAddContactScreenFromView:(id<BYContactListViewProtocol>)view {
    if (view.presenter) {
        if ([view.presenter conformsToProtocol:@protocol(BYAddModuleDelegate)]) {
            id<BYAddModuleDelegate> delegate = (BYContactListPresenter *)(view.presenter);
            UINavigationController *addContactsView = (UINavigationController *)[BYAddContactRouter createAddContactModule:delegate];
            if ([view isKindOfClass:[UIViewController class]]) {
                [((UIViewController *)view) presentViewController:addContactsView animated:YES completion:nil];
            }
        }
    }
}

+ (UIStoryboard *)storyboard {
    return [UIStoryboard storyboardWithName:@"BYVIPER" bundle:[NSBundle mainBundle]];
}
@end
