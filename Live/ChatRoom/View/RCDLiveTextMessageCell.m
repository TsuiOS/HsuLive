//
//  RCDLiveTextMessageCell.m
//  Live
//
//  Created by xuning on 2018/11/5.
//  Copyright © 2018 xuning. All rights reserved.
//

#import "RCDLiveTextMessageCell.h"
#import "RCCRMessageModel.h"
#import <YYKit.h>

@interface RCDLiveTextMessageCell()

/*!
 显示消息内容的Label
 */
@property(nonatomic, strong) YYLabel *messsageLabel;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation RCDLiveTextMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.bgView];
        [self.contentView addSubview:self.messsageLabel];
    }
    return self;
}

- (void)setModel:(RCCRMessageModel *)model {
    
    _model = model;
    // 进行数据赋值
    // 创建一个可变属性字符串
    NSMutableAttributedString *finalStr = [[NSMutableAttributedString alloc]init];
    UIFont *font = [UIFont systemFontOfSize:15];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 3;
 
    UIImage *image = [UIImage imageNamed:@"dengji_1"]; // 测试数据
    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [finalStr appendAttributedString:attachText];
    [finalStr appendAttributedString:[[NSAttributedString alloc] initWithString:model.name attributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    
    [finalStr appendAttributedString:[[NSAttributedString alloc] initWithString:model.message attributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName:[UIColor yellowColor],NSParagraphStyleAttributeName:paragraphStyle}]];
    
    [finalStr addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, finalStr.length)];

    
    self.messsageLabel.attributedText = finalStr;
    
    // 很关键 宽度一定要准确 (250 是tableview的宽度,-10是让文本左右留出10的宽度)
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(250 - 10.0f, MAXFLOAT)];
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:self.messsageLabel.attributedText];
    self.messsageLabel.textLayout = textLayout;
    
    self.messsageLabel.frame = CGRectMake(4,4, textLayout.textBoundingSize.width, textLayout.textBoundingSize.height);
    self.bgView.frame = CGRectMake(0, 0, self.messsageLabel.width + 8, self.messsageLabel.height + 6);
}


// 根绝数据计算cell的高度
- (CGFloat)heightForModel:(RCCRMessageModel *)message {
    
    [self setModel:message];
    // 很关键
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(250 - 10.0f, MAXFLOAT)];
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:self.messsageLabel.attributedText];
    CGSize __labelSize = textLayout.textBoundingSize;
    return __labelSize.height + 15;
}

#pragma mark - lazy
- (YYLabel *)messsageLabel {
    
    if (_messsageLabel == nil) {
        _messsageLabel = [[YYLabel alloc]init];
        _messsageLabel.numberOfLines = 0;
        _messsageLabel.textAlignment = NSTextAlignmentLeft;
        _messsageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _messsageLabel.displaysAsynchronously = YES;
        _messsageLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return _messsageLabel;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.25];
        // 如果切原价卡顿的话,可以使用背景图
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

@end
