//
//  JNPlayerViewController.m
//  Live
//
//  Created by xuning on 2018/11/6.
//  Copyright © 2018 xuning. All rights reserved.
//

#import "JNPlayerViewController.h"
#import "JNPlayerChatViewController.h"
#import <YYKit.h>

@interface JNPlayerViewController ()

@property (nonatomic, strong) JNPlayerChatViewController *chatVc;


@end

@implementation JNPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0   green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    // 拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureView:)];
    [self.view addGestureRecognizer:pan];
    
    [self addChildViewController:self.chatVc];
    [self.view addSubview:self.chatVc.view];
    self.chatVc.view.frame = self.view.bounds;
    
}

//手势\清屏动画
- (void)panGestureView:(UIPanGestureRecognizer*)pan {
    
    
    CGPoint point = [pan translationInView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
        {
            self.chatVc.view.left = self.view.width + point.x;
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            if  (point.x > -kScreenWidth/4){ //临界点
                [UIView animateWithDuration:0.3 animations:^{
                    self.chatVc.view.left = self.view.width;
                    
                }completion:^(BOOL finished) {
                    
                }];
            }else{
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.chatVc.view.left = 0;
                }completion:^(BOOL finished) {
                    
                }];
            }
        }
            break;
        default:
            break;
    }
}



- (JNPlayerChatViewController *)chatVc {
    if (_chatVc == nil) {
        _chatVc = [[JNPlayerChatViewController alloc]init];
    }
    return _chatVc;
}


@end
