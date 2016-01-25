//
//  WFMenuController.h
//  menu
//
//  Created by babywolf on 16/1/25.
//  Copyright © 2016年 com.babywolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFMenuController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *mainView;

@end
