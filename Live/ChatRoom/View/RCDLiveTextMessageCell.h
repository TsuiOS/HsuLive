//
//  RCDLiveTextMessageCell.h
//  Live
//
//  Created by xuning on 2018/11/5.
//  Copyright © 2018 xuning. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCCRMessageModel;
NS_ASSUME_NONNULL_BEGIN

@interface RCDLiveTextMessageCell : UITableViewCell

@property (nonatomic, strong) RCCRMessageModel *model;

- (CGFloat)heightForModel:(RCCRMessageModel *)message;
@end

NS_ASSUME_NONNULL_END
