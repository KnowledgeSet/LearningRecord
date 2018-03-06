//
//  UIView+BYExt.h
//  AllTestProject
//
//  Created by by_r on 2017/12/8.
//  Copyright © 2017年 by_r. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BYExt)
@property (nonatomic, assign) CGFloat   left;
@property (nonatomic, assign) CGFloat   right;
@property (nonatomic, assign) CGFloat   top;
@property (nonatomic, assign) CGFloat   bottom;
@property (nonatomic, assign) CGFloat   width;
@property (nonatomic, assign) CGFloat   height;

@property (nonatomic, strong, readonly) UIColor *randomColor;

@end
