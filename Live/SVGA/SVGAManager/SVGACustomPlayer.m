//
//  SVGACustomPlayer.m
//  HelloLive
//
//  Created by xuning on 2018/11/5.
//  Copyright © 2018 Hsu. All rights reserved.
//

#import "SVGACustomPlayer.h"

@implementation SVGACustomPlayer

// xuning添加
/**
 每个view都有这个方法，用来处理用户的操作事件。
 @return 它返回：self，代表这个view会接受用户的操作事件，返回：nil，则代表这个view不会接受用户的操作事件。
 */

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return nil;
}

@end
