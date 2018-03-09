//
//  BYAddContactRouter.m
//  LearningRecord
//
//  Created by by_r on 2018/3/9.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import "BYAddContactRouter.h"
#import "BYAddContactPresenter.h"
#import "BYAddContactInteractor.h"
#import "BYAddContactLocalDataManager.h"
#import "BYAddContactRouter.h"
#import "BYAddContactView.h"
@implementation BYAddContactRouter
+ (UIViewController *)createAddContactModule:(id<BYAddModuleDelegate>)delegate {
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"addContactViewNav"];
    if ([navController.childViewControllers.firstObject conformsToProtocol:@protocol(BYAddContactViewProtocol)]) {
        BYAddContactView *view = navController.childViewControllers.firstObject;
        id<BYAddContactPresenterProtocol, BYAddContactInteractorOutputProtocol> presenter = [BYAddContactPresenter new];
        id<BYAddContactInteractorInputProtocol> interactor = [BYAddContactInteractor new];
        id<BYAddContactLocalDataManagerInputProtocol> localDatamanager = [BYAddContactLocalDataManager new];
        id<BYAddContactRouterProtocol> router = [BYAddContactRouter new];
        
        // Connecting
        view.presenter = presenter;
        presenter.view = view;
        presenter.router = router;
        presenter.interactor = interactor;
        presenter.delegate = delegate;
        interactor.presenter = presenter;
        interactor.localDatamanager = localDatamanager;
        
        return navController;
    }
    return [UIViewController new];
}

- (void)dismissAddContactInterfaceFromView:(id<BYAddContactViewProtocol>)view completion:(void (^)(void))compltion {
    if (view && [view isKindOfClass:[UIViewController class]]) {
        [(UIViewController *)view dismissViewControllerAnimated:YES completion:compltion];
    }
}

+ (UIStoryboard *)storyboard {
    return [UIStoryboard storyboardWithName:@"BYVIPER" bundle:nil];
}
@end
