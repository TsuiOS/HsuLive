//
//  JNSVGAViewController.m
//  Live
//
//  Created by xuning on 2018/11/9.
//  Copyright © 2018 xuning. All rights reserved.
//

#import "JNSVGAViewController.h"
#import "SVGAManager.h"

@interface JNSVGAViewController ()
@property (nonatomic, strong) SvgaManager *giftSvgaManager;

@end

@implementation JNSVGAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"模拟礼物消息" style:(UIBarButtonItemStyleDone) target:self action:@selector(addMessage)];
    
}
- (void)addMessage {
    NSArray *items = @[
                       @"http://phq4iiqb5.bkt.clouddn.com/HamburgerArrow.svga",
                       @"http://phq4iiqb5.bkt.clouddn.com/Walkthrough.svga",
                       @"http://phq4iiqb5.bkt.clouddn.com/PinJump.svga",
                       @"http://phq4iiqb5.bkt.clouddn.com/EmptyState.svga",
                       @"http://phq4iiqb5.bkt.clouddn.com/heartbeat.svga",
                       @"http://phq4iiqb5.bkt.clouddn.com/halloween.svga",
                       @"http://phq4iiqb5.bkt.clouddn.com/posche.svga",
                       @"http://phq4iiqb5.bkt.clouddn.com/kingset.svga",
                       @"http://phq4iiqb5.bkt.clouddn.com/TwitterHeart.svga",
                       @"http://phq4iiqb5.bkt.clouddn.com/angel.svga"
                       ];
    SvgaMgrModel *model = [[SvgaMgrModel alloc]init];
    model.svgaUrl = items[arc4random() % 10];
    [self.giftSvgaManager loadSvgaItem:model superview:self.view SVGAFrame:self.view.frame];

}

- (SvgaManager *)giftSvgaManager {
    if (_giftSvgaManager == nil) {
        _giftSvgaManager = [[SvgaManager alloc]init];
        _giftSvgaManager.type = SvgaMgrTypeGifts;
        _giftSvgaManager.aPlayer.tag = 0;
        _giftSvgaManager.clearsAfterStop = YES;
        _giftSvgaManager.loops = 1;
    }
    return _giftSvgaManager;
}

- (void)dealloc {
    
}
@end
