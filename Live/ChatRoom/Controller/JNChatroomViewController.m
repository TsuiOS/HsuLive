//
//  JNChatroomViewController.m
//  Live
//
//  Created by xuning on 2018/11/5.
//  Copyright © 2018 xuning. All rights reserved.
//

#import "JNChatroomViewController.h"
#import "RCCRMessageModel.h"
#import "RCDLiveTextMessageCell.h"
#import <Masonry.h>
#import <YYKit.h>

static NSString *const rctextCellIndentifier = @"rctextCellIndentifier";
@interface JNChatroomViewController ()<UITableViewDelegate,UITableViewDataSource>

/*!
 聊天内容的消息Cell数据模型的数据源
 
 @discussion 数据源中存放的元素为消息Cell的数据模型，即RCCRMessageModel对象。
 */
@property(nonatomic, strong) NSMutableArray<RCCRMessageModel *> *conversationDataRepository;
/*!
 会话页面的CollectionView
 */
@property(nonatomic, strong) UITableView *conversationMessageTableView;

@property (nonatomic, strong) RCDLiveTextMessageCell *tempMsgCell;


@end

@implementation JNChatroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"随机消息" style:(UIBarButtonItemStyleDone) target:self action:@selector(addMessage)];
    // 用于计算高度
    self.tempMsgCell = [[RCDLiveTextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rctextCellIndentifier];
    
    [self setupUI];
    // 模拟一些数据源
    NSArray *nameArr = @[@"看我的大白眼：",
                         @"我是大白：",
                         @"大白眼：",
                         @"大白：",
                         @"吴老二："];
    NSArray *messageArr = @[@"平时使用Mac自带终端时是不是觉得主题太单调、代码不能自动提示、语法不能高亮。那么今天就来调教一下，让它变得漂亮些、活儿更好一些。",
                            @"简单介绍下oh-my-zsh",
                            @"Oh My Zsh是一款社区驱动的命令行工具，正如它的主页上说的，Oh My Zsh 是一种生活方式。 它基于zsh命令行，提供了主题配置，插件机制，已经内置的便捷操作。",
                            @"哈哈哈哈哈"];
    // 向数据源中随机放入500个Model
    for (int i=0; i<100; i++) {
        RCCRMessageModel *model = [[RCCRMessageModel alloc] init];
        model.name = nameArr[arc4random()%nameArr.count];
        model.message = messageArr[arc4random()%messageArr.count];
        [self.conversationDataRepository addObject:model];
    }
    
    [self.conversationMessageTableView reloadData];
    
}

- (void)addMessage {
    
    // 模拟一些数据源
    NSArray *nameArr = @[@"看我的大白眼：",
                         @"我是大白：",
                         @"大白眼：",
                         @"大白：",
                         @"吴老二："];
    NSArray *messageArr = @[@"平时使用Mac自带终端时是不是觉得主题太单调、代码不能自动提示、语法不能高亮。那么今天就来调教一下，让它变得漂亮些、活儿更好一些。",
                            @"简单介绍下oh-my-zsh",
                            @"Oh My Zsh是一款社区驱动的命令行工具，正如它的主页上说的，Oh My Zsh 是一种生活方式。 它基于zsh命令行，提供了主题配置，插件机制，已经内置的便捷操作。",
                            @"哈哈哈哈哈"];
    
    RCCRMessageModel *model = [[RCCRMessageModel alloc] init];
    model.name = nameArr[arc4random()%nameArr.count];
    model.message = messageArr[arc4random()%messageArr.count];
    
    [self.conversationDataRepository addObject:model];

    
    // 插入到tableView中
    [self.conversationMessageTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.conversationDataRepository.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    // 再滚动到最底部
    [self.conversationMessageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.conversationDataRepository.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)setupUI {
    
    [self.view addSubview:self.conversationMessageTableView];
    [self.conversationMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(240);
        make.top.mas_equalTo(200);
    }];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.conversationDataRepository.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RCCRMessageModel *model = [self.conversationDataRepository objectAtIndex:indexPath.row];
    
    RCDLiveTextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:rctextCellIndentifier forIndexPath:indexPath];;
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RCCRMessageModel *model = [self.conversationDataRepository objectAtIndex:indexPath.row];
    if (model.cellHeight == 0) {
        
        CGFloat cellHeight = [self.tempMsgCell heightForModel:model];
        model.cellHeight = cellHeight;
        return cellHeight;
        
    }else{
        return model.cellHeight;
    }
}




- (UITableView *)conversationMessageTableView{
    
    if (_conversationMessageTableView == nil) {
        _conversationMessageTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _conversationMessageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _conversationMessageTableView.delegate = self;
        _conversationMessageTableView.dataSource = self;
        _conversationMessageTableView.alwaysBounceVertical = YES;
        _conversationMessageTableView.showsVerticalScrollIndicator = NO;
        [_conversationMessageTableView registerClass:[RCDLiveTextMessageCell class] forCellReuseIdentifier:rctextCellIndentifier];
        _conversationMessageTableView.backgroundColor = [UIColor clearColor];
        _conversationMessageTableView.estimatedRowHeight = 0;
        _conversationMessageTableView.estimatedSectionHeaderHeight = 0;
        _conversationMessageTableView.estimatedSectionFooterHeight = 0;
    }
    return _conversationMessageTableView;
}

- (NSMutableArray<RCCRMessageModel *> *)conversationDataRepository {
    if (_conversationDataRepository == nil) {
        _conversationDataRepository = [NSMutableArray array];
    }
    return _conversationDataRepository;
}


@end
