//
//  LivingVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/21.
//

#import "UBLLivingVC.h"

static const CGFloat listContainerViewY = 190;
static const CGFloat attentionBtnWidth = 75;

@interface UBLLivingVC ()
<
JXCategoryListContainerViewDelegate,
JXCategoryViewDelegate,
JXCategoryTitleViewDataSource
>

@property(nonatomic,strong)UBLLivingNavView *livingNavView;
@property(nonatomic,strong)UBLLivingVideoView *userHeaderView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryDotView *categoryTitleView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)UIButton *attentionBtn;

@property(nonatomic,strong)NSMutableArray <NSString *> *titlesMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCMutArr;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;
@property(nonatomic,assign)BOOL isNeedIndicatorPositionChangeItem;
@property(nonatomic,assign)__block BOOL isShowBackBtn;
@property(nonatomic,copy)MKDataBlock livingVCBlock;

@end

@implementation UBLLivingVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    
    [self configChatRoomIMwithSocketIO];
    [self receiveMeg];
    [self joinRoom];
    [self leaveRoom];
    [self onlineCount];
    
    self.userHeaderView.alpha = 1;
    self.categoryTitleView.alpha  = 1;
    self.attentionBtn.alpha = 1;
    /*
     roomId:直播间ID 【非必须参数】
     streamSharpness:流分辨率, ld: 标清, hd: 高清, cnhd: 中文高清, wx: 卫星, 默认返回分辨率最高的【非必须参数】
     protocolType:源协议类型, m3u8, flv【非必须参数】
     */
    @weakify(self)
    [UBLNetWorkManager getRequestWithUrlPath:[NSString stringWithFormat:@"%@?%@&%@",UBLUrlRoomDetail,@"roomId=100032",@"streamSharpness=?",@"protocolType=?"]
                                  parameters:@{
                                      @"roomId":@"1000032",//直播间ID 【非必须参数】
                                      @"streamSharpness":@"",//流分辨率, ld: 标清, hd: 高清, cnhd: 中文高清, wx: 卫星, 默认返回分辨率最高的【非必须参数】
                                      @"protocolType":@""//源协议类型, m3u8, flv【非必须参数】
                                  }
                                    finished:^(UBLNetWorkResult * _Nonnull result) {
        @strongify(self)
        NSLog(@"result = %@",result);
        self.livingModel = [UBLLivingModel mj_objectWithKeyValues:result.resultData];
        [self.livingNavView richElementsInViewWithModel:self.livingModel];
        [self.attentionBtn setTitle:[NSString ensureNonnullString:[NSString stringWithFormat:@"%ld",self.livingModel.fansNum] ReplaceStr:@"暂无数据"]
                           forState:UIControlStateNormal];
        [self.attentionBtn setTitle:[NSString ensureNonnullString:[NSString stringWithFormat:@"%ld",self.livingModel.fansNum] ReplaceStr:@"暂无数据"]
                           forState:UIControlStateSelected];
        
        UBLChatVC *chatVC = (UBLChatVC *)self.childVCMutArr[0];
        [chatVC setScrollContentMutArr:(NSMutableArray *)@[[NSString ensureNonnullString:self.livingModel.announcement ReplaceStr:@"暂无数据"]]];
        chatVC.scrollLabelView.alpha = 1;
        
        self.attentionBtn.selected = self.livingModel.is_attention;
        //1、flv；2、hls；3、flvs；4、hlss
//        self.userHeaderView.assetURLStr = @"http://liveplay.yikating.net/live/100037.flv?txSecret=799b50d5a0caebe99c7539995bf5697e&txTime=5FC10589";//临时测试的流地址数据
//        self.userHeaderView.assetURLStr = [[NSBundle mainBundle] pathForResource:@"iph_X" ofType:@"mp4"];//本地文件可以正常播放
        self.userHeaderView.assetURLStr = self.livingModel.playAddr[3].playUrl;//服务器地址
        NSLog(@"流地址：%@",self.userHeaderView.assetURLStr);
    }];
}
//
//sendMsg
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self sendMsg];
}

-(void)configChatRoomIMwithSocketIO{
    SocketIOTools.sharedInstance.urlStr = @"http://222.186.150.148:8002/chat";//@"http://172.24.135.22:9092/chat";//

    id info1 = @{@"roomId":@"10080",
                  @"token":@"295060456",
                  @"user":@{@"username":@"Jobs"}};
    //链接消息
    @weakify(self)
    [SocketIOTools.sharedInstance linkServerWithInfo:info1
                                         serverBlock:^(id data) {
        @strongify(self);
        if ([data isKindOfClass:SocketIOModel.class]) {
            SocketIOModel *socketIOModel = (SocketIOModel *)data;
            NSLog(@"频道名:%@,服务器返回数据:%@",socketIOModel.channelName,socketIOModel.serverReturnData);
        }
    }];
}
//订阅消息:加入房间 链接以后立即订阅
-(void)joinRoom{
    @weakify(self)
    [SocketIOTools.sharedInstance recevieInfoFromChannelName:@"joinRoom"
                                         withServerDataBlock:^(id data) {
        @strongify(self);
        if ([data isKindOfClass:SocketIOModel.class]) {
            SocketIOModel *socketIOModel = (SocketIOModel *)data;
            NSLog(@"频道名:%@,服务器返回数据:%@",socketIOModel.channelName,socketIOModel.serverReturnData);
        }
    }];
}
//订阅消息:离开房间(为了防止一台设备、一个IP、PC端多窗口事件，所以有且仅有所有的该主token名下的全部“子token”全部退出的时候，才会收到leaveRoom频道发送的退出消息)  链接以后立即订阅
-(void)leaveRoom{
    @weakify(self)
    [SocketIOTools.sharedInstance recevieInfoFromChannelName:@"leaveRoom"
                                         withServerDataBlock:^(id data) {
        @strongify(self);
        if ([data isKindOfClass:SocketIOModel.class]) {
            SocketIOModel *socketIOModel = (SocketIOModel *)data;
            NSLog(@"频道名:%@,服务器返回数据:%@",socketIOModel.channelName,socketIOModel.serverReturnData);
        }
    }];
}
//订阅消息:房间在线人数变化 链接以后立即订阅
-(void)onlineCount{
    @weakify(self)
    [SocketIOTools.sharedInstance recevieInfoFromChannelName:@"onlineCount"
                                         withServerDataBlock:^(id data) {
        @strongify(self);
        if ([data isKindOfClass:SocketIOModel.class]) {
            SocketIOModel *socketIOModel = (SocketIOModel *)data;
            NSLog(@"频道名:%@,服务器返回数据:%@",socketIOModel.channelName,socketIOModel.serverReturnData);
        }
    }];
}
//接受消息
-(void)receiveMeg{
    @weakify(self)
    [SocketIOTools.sharedInstance recevieInfoFromChannelName:@"message"
                                         withServerDataBlock:^(id data) {
        @strongify(self);
        if ([data isKindOfClass:SocketIOModel.class]) {
            SocketIOModel *socketIOModel = (SocketIOModel *)data;
            NSLog(@"频道名:%@,服务器返回数据:%@",socketIOModel.channelName,socketIOModel.serverReturnData);
        }
    }];
}
//发送消息
-(void)sendMsg{
    @weakify(self)
    [SocketIOTools.sharedInstance sendInfoToServer:@{
        @"messageId": @"88889999", // 消息唯一ID
        @"username": @"88889999", // 根据产品需求进入直播间但未登录统一username为"访客"
        @"messageType": @(1),   // 1文本, 2礼物, 3表情,
        @"message": @"消息"  // 消息
    }
                                       channelName:@"message"
                                   withReturnBlock:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    PrintRetainCount(self);
//    [self.userHeaderView.avPlayerManager stop];
    [self.userHeaderView.ijkPlayerManager stop];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
#pragma mark - JXCategoryViewDelegate
-(void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
//    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];

    //点击以后红点消除
    if ([self.dotStatesMutArr[index] boolValue]) {
        self.dotStatesMutArr[index] = @(NO);
        self.categoryTitleView.dotStates = self.dotStatesMutArr;
        [categoryView reloadCellAtIndex:index];
    }
}

-(void)categoryView:(JXCategoryBaseView *)categoryView
didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
#pragma mark - JXCategoryListContainerViewDelegate
-(id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                         initListForIndex:(NSInteger)index{
    return self.childVCMutArr[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titlesMutArr.count;
}

-(void)actionBlockLivingVC:(MKDataBlock _Nullable)livingVCBlock{
    self.livingVCBlock = livingVCBlock;
}
#pragma mark —— lazyLoad
-(UBLLivingVideoView *)userHeaderView{
    if (!_userHeaderView) {
        _userHeaderView = UBLLivingVideoView.new;
        @weakify(self)
        [_userHeaderView actionLivingVideoViewBlock:^(id data) {
            @strongify(self)

        }];
        [self.view addSubview:_userHeaderView];
        [_userHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(rectOfStatusbar());
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(listContainerViewY);
        }];
    }return _userHeaderView;
}

-(JXCategoryDotView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryDotView.new;
        _categoryTitleView.backgroundColor = kWhiteColor;
        _categoryTitleView.titles = self.titlesMutArr;
        _categoryTitleView.dotStates = self.dotStatesMutArr;
        _categoryTitleView.indicators = @[self.lineView];
        _categoryTitleView.delegate = self;
        _categoryTitleView.titleSelectedColor = RGBCOLOR(105,
                                                         144,
                                                         239);
        _categoryTitleView.titleColor = kBlackColor;
        _categoryTitleView.dotSize = CGSizeMake(5, 5);
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:14
                                                         weight:UIFontWeightMedium];
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryTitleView.contentScrollView = self.listContainerView.scrollView;//
        _categoryTitleView.listContainer = self.listContainerView;
        _categoryTitleView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryTitleView.titleColorGradientEnabled = YES;
        _categoryTitleView.titleLabelZoomEnabled = YES;
        [self.view addSubview:_categoryTitleView];
        [_categoryTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userHeaderView.mas_bottom);
            make.height.mas_equalTo(categoryTitleViewHeight);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view).offset(-attentionBtnWidth);
        }];
    }return _categoryTitleView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView
                                                                      delegate:self];
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(categoryTitleViewHeight + listContainerViewY + rectOfStatusbar());
        }];
    }return _listContainerView;
}

-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = UIButton.new;
        _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                          weight:UIFontWeightMedium];
        [_attentionBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                           @"Others",
                                           @"关注",
                                           @"+关注")
                       forState:UIControlStateNormal];
        [_attentionBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                           @"Others",
                                           @"关注",
                                           @"关注")
                       forState:UIControlStateSelected];
        [_attentionBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                       imageTitleSpace:3];
        
        @weakify(self)
        [[_attentionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            [self->_attentionBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                  imageTitleSpace:5];

            if (self.livingVCBlock) {
                self.livingVCBlock(x);
            }
        }];
        [self.view addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.categoryTitleView);
            make.left.equalTo(self.categoryTitleView.mas_right);
            make.right.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        [UIView setView:_attentionBtn
                  layer:_attentionBtn.imageView.layer
          gradientLayer:HEXCOLOR(0x83C8FF)
               endColor:HEXCOLOR(0x3977FE)];
    }return _attentionBtn;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = RGBCOLOR(105, 144, 239);
        _lineView.indicatorWidth = 30;
    }return _lineView;
}

-(NSMutableArray<NSString *> *)titlesMutArr{
    if (!_titlesMutArr) {
        _titlesMutArr = NSMutableArray.array;
        [_titlesMutArr addObject:@"聊天"];
    }return _titlesMutArr;
}

-(NSMutableArray<UIViewController *> *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [_childVCMutArr addObject:UBLChatVC.new];
    }return _childVCMutArr;
}

-(NSMutableArray<NSNumber *> *)dotStatesMutArr{
    if (!_dotStatesMutArr) {
        _dotStatesMutArr = NSMutableArray.array;
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
    }return _dotStatesMutArr;
}

-(UBLLivingNavView *)livingNavView{
    if (!_livingNavView) {
        _livingNavView = UBLLivingNavView.new;
        @weakify(self)
        [_livingNavView actionBlockLivingNavView:^(id data) {
            @strongify(self)
            [self backBtnClickEvent:nil];
        }];
        
        [self.view addSubview:_livingNavView];
        [_livingNavView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(65);
            make.top.equalTo(self.view).offset(rectOfStatusbar());
            make.left.right.equalTo(self.view);
        }];
    }return _livingNavView;
}

@end
