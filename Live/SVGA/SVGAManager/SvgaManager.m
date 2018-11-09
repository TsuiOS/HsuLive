//
//  SvgaManager.m
//  HelloLive
//
//  Created by xuning on 2018/11/5.
//  Copyright © 2018 Hsu. All rights reserved.
//

#import "SvgaManager.h"
#import <YYKit.h>

@interface SvgaManager()<SVGAPlayerDelegate>

@property (nonatomic, assign)BOOL isPlay;

@property (nonatomic, strong) SVGAParser *aParser;

/**
 存放需要执行的svga动画
 */
@property (nonatomic, strong) NSMutableArray<SvgaMgrModel *>* svgaItems;

@property (nonatomic, strong) UIView *tempSuperView;
// 是否是礼物操作
@property (nonatomic, assign) BOOL isGiftSvga;

// 是否是座驾操作
@property (nonatomic, assign) BOOL isMountsSvga;

@end

@implementation SvgaManager

- (instancetype)init {
    if (self = [super init]) {
        self.isGiftSvga = NO;
        self.isMountsSvga = NO;
    }
    return self;
}

- (void)loadSvgaItem:(SvgaMgrModel *)model superview:(UIView *)view SVGAFrame:(CGRect)rect {
    
    self.tempSuperView = view;
    
    // 缓存数据
    [self.svgaItems addObject:model];
    
    if (self.type == SvgaMgrTypeMounts) { // 进场特效
        
        [view addSubview:self.aPlayer];
        [self aPlayerSet:rect];
        
    }else{ // 礼物效果
        
        // 根据需求,是否需要修改礼物图层顺序
        for (UIView *svgaView in view.subviews) {
            
            if ([svgaView isKindOfClass:[SVGAPlayer class]] && svgaView.tag == 1) { // 这里直播间存在进场特效
                [view insertSubview:self.aPlayer belowSubview:svgaView];
                [self aPlayerSet:rect];
                return;
            }
        }
        
        // 正常情况
        [view addSubview:self.aPlayer];
        [self aPlayerSet:rect];
        
    }
    
    
}

- (void)aPlayerSet:(CGRect)rect{
    
    self.aPlayer.frame = rect;
    self.aPlayer.loops = (int)self.loops;
    self.aPlayer.clearsAfterStop = self.clearsAfterStop;
    
    if (self.isPlay != YES) {
        [self playSvga];
    }
}

#pragma mark - Private
- (void)playSvga {
    
    
    if (self.svgaItems.count == 0 ) { //队列中不存在效果
        return;
    }
    
    self.isPlay = YES;
    __weak typeof(self) weakSelf = self;
    
    SvgaMgrModel * model = self.svgaItems.firstObject;
    
    // 执行动画
    [self.aParser parseWithURL:[NSURL URLWithString:model.svgaUrl] completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
        
        if (videoItem) {
            
            weakSelf.aPlayer.videoItem = videoItem;
            [weakSelf.aPlayer startAnimation];
            self.isGiftSvga = YES;
            
            if (self.type == SvgaMgrTypeMounts) { // 这里入场动画的文字特效
                self.isMountsSvga = YES;
                [self showMounstView:model];
            }
            
            if (weakSelf.svgaItems.count > 0) {
                [weakSelf.svgaItems removeFirstObject];
            }
        }
        
    } failureBlock:^(NSError * _Nullable error) {
        
    }];
    
}

// 执行特效文字
- (void)showMounstView:(SvgaMgrModel *)model {
    // TODO:
}

#pragma mark - <SVGAPlayerDelegate>
- (void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player {
    
    if (self.svgaItems.count == 0) {
        
        [self.aPlayer removeFromSuperview];
        self.isGiftSvga = NO;
        
        if (self.isMountsSvga == NO && self.isGiftSvga == NO) {
            self.isPlay = NO;
        }
        
    }else{
        
        self.isGiftSvga = NO;
        
//        if (self.type == SvgaMgrTypeGifts && self.isGiftSvga == NO) {
//            [self playSvga];
//        }else if (self.type == SvgaMgrTypeMounts && self.isMountsSvga == NO){
//            [self playSvga];
//        }
        
        if (self.isMountsSvga == NO && self.isGiftSvga == NO) {
            [self playSvga];
        }
    }
    
}

- (void)dealloc{
    
    
}

#pragma mark - setter/getter
- (SVGACustomPlayer *)aPlayer {
    
    if (_aPlayer == nil) {
        _aPlayer = [[SVGACustomPlayer alloc] init];
        _aPlayer.delegate = self;
        _aPlayer.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _aPlayer;
}

- (SVGAParser *)aParser{
    
    if (_aParser == nil) {
        _aParser = [[SVGAParser alloc]init];
    }
    
    return _aParser;
}

- (NSMutableArray<SvgaMgrModel *> *)svgaItems {
    
    if (_svgaItems == nil) {
        _svgaItems = [NSMutableArray array];
    }
    return _svgaItems;
}

@end
