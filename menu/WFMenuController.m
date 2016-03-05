//
//  WFMenuController.m
//  menu
//
//  Created by babywolf on 16/1/25.
//  Copyright © 2016年 com.babywolf. All rights reserved.
//

#import "WFMenuController.h"
#define kMaxOffsetX 300.0
#define kMaxOffsetY 40.0

@implementation WFMenuController

- (void)viewDidLoad {
    _leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    _leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_leftView];
    
    _rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    _rightView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_rightView];
    
    _mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    _mainView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_mainView];
    
    [self addGesture];
    [super viewDidLoad];
}

- (void)addGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.mainView addGestureRecognizer:tap];
    [self.mainView addGestureRecognizer:pan];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        sender.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)panAction:(UIPanGestureRecognizer *)sender {
//    NSLog(@"%f",sender.view.frame.origin.x);
    
    CGFloat x = sender.view.frame.origin.x;
    if (x <= 0) {
        _leftView.hidden = YES;
        _rightView.hidden = NO;
    }else {
        _leftView.hidden = NO;
        _rightView.hidden = YES;
    }
    
    //获取拖动速度
    CGPoint velocitypoint = [sender velocityInView:_mainView];
    
    CGPoint point = [sender translationInView:self.view];
    CGFloat scale = kMaxOffsetY / kMaxOffsetX;
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, point.x, 0);
//    NSLog(@"%f",point.x*kMaxOffsetY/kMaxOffsetX*scale);
    if (x <= 0) {
        sender.view.transform = CGAffineTransformScale(sender.view.transform, 1, (self.view.frame.size.height-2*(-point.x)*scale)/self.view.frame.size.height);
    }else {
        sender.view.transform = CGAffineTransformScale(sender.view.transform, 1, (self.view.frame.size.height-2*point.x*scale)/self.view.frame.size.height);
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (sender.state == UIGestureRecognizerStateEnded) {
            //(sender.view.transform.tx > self.view.frame.size.width / 2 && velocitypoint.x >= 0)表示滑动超过一半并且方向向右，则右边至最大
            if ((sender.view.transform.tx > self.view.frame.size.width / 2 && velocitypoint.x >= 0) || velocitypoint.x > 1000) {
//                NSLog(@"右至最大");
                sender.view.transform = CGAffineTransformMakeTranslation(kMaxOffsetX, 0);
                sender.view.transform = CGAffineTransformScale(sender.view.transform, 1, (self.view.frame.size.height-2*kMaxOffsetX*scale)/self.view.frame.size.height);
            }else if ((sender.view.transform.tx < (-self.view.frame.size.width / 2) && velocitypoint.x <= 0) || velocitypoint.x < -1000){
//                NSLog(@"左至最大");
                sender.view.transform = CGAffineTransformMakeTranslation(-kMaxOffsetX, 0);
                sender.view.transform = CGAffineTransformScale(sender.view.transform, 1, (self.view.frame.size.height-2*kMaxOffsetX*scale)/self.view.frame.size.height);
            }else {
                sender.view.transform = CGAffineTransformMakeTranslation(0, 0);
            }
        }
    }];
    
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
}

@end
