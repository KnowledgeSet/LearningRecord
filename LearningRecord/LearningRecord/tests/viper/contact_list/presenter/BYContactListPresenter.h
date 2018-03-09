//
//  BYContactListPresenter.h
//  LearningRecord
//
//  Created by by_r on 2018/3/8.
//  Copyright © 2018年 by_r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYContactListProtocols.h"
#import "BYAddContactProtocols.h"

@interface BYContactListPresenter : NSObject<BYContactListPresenterProtocol, BYContactListInteractorOutputProtocol, BYAddModuleDelegate>

@end
