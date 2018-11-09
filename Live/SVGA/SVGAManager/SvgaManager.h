//
//  SvgaManager.h
//  HelloLive
//
//  Created by xuning on 2018/11/5.
//  Copyright © 2018 Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVGA.h>
#import "SvgaMgrModel.h"
#import "SVGACustomPlayer.h"

typedef NS_ENUM(NSInteger, SvgaMgrType)
{
    SvgaMgrTypeGifts = 0, //类型礼物
    SvgaMgrTypeMounts,    //进场动画
};

NS_ASSUME_NONNULL_BEGIN

@interface SvgaManager : NSObject
/**
 单个动画循环次数
 */
@property (nonatomic, assign) NSInteger loops;

@property (nonatomic, assign) BOOL clearsAfterStop;

@property (nonatomic, assign) SvgaMgrType type;

@property (nonatomic, strong) SVGACustomPlayer *aPlayer; //Tag 礼物：0  座驾：1  用于区分


/**
 添加svga动画 等待执行
 
 @param model svga动画关联数据
 */
-(void)loadSvgaItem:(SvgaMgrModel *)model superview:(UIView *)view SVGAFrame:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
