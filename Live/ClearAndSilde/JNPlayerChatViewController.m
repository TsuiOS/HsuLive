//
//  JNPlayerChatViewController.m
//  Live
//
//  Created by xuning on 2018/11/6.
//  Copyright © 2018 xuning. All rights reserved.
//

#import "JNPlayerChatViewController.h"
#import <YYKit.h>

@interface JNPlayerChatViewController ()

@end

@implementation JNPlayerChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.5];
    // 拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureView:)];
    [self.view addGestureRecognizer:pan];
}

#pragma mark - action
- (void)panGestureView:(UIPanGestureRecognizer*)pan
{
    
    CGPoint point = [pan translationInView:self.view];
    if (pan.state == UIGestureRecognizerStateChanged){
        if (point.x <= 0 )  return;
        self.view.left = point.x;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (point.x <  self.view.width/6){ // 临界点
            [UIView animateWithDuration:0.3 animations:^{
                self.view.left = 0;
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                self.view.left = self.view.width;
            }completion:^(BOOL finished) {
                
            }];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
