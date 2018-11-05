//
//  RCCRMessageModel.h
//  Live
//
//  Created by xuning on 2018/11/5.
//  Copyright © 2018 xuning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCCRMessageModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *level;

@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
