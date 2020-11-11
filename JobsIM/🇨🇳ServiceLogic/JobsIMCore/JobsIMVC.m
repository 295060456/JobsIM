//
//  JobsIMVC.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "JobsIMVC.h"
#import "JobsIMInputview.h"
#import "JobsIMChatInfoModel.h"

static inline CGFloat JobsIMInputviewHeight(){
    return 50;
}

@interface JobsIMVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)JobsIMInputview *inputview;
@property(nonatomic,strong)UITableView *tableView;//显示数据
@property(nonatomic,strong)UIBarButtonItem *shareBtnItem;
@property(nonatomic,strong)UIButton *shareBtn;
//data
@property(nonatomic,strong)NSMutableArray <JobsIMChatInfoModel *>*chatInfoModelMutArr;//聊天信息

@end

@implementation JobsIMVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    
    if ([self.requestParams isKindOfClass:JobsIMChatInfoModel.class]) {
        JobsIMChatInfoModel *model = (JobsIMChatInfoModel *)self.requestParams;
        self.gk_navTitle = model.senderUserName;
    }
    
    if (self.navigationController.viewControllers.count - 1) {//从上个页面推过来才有返回键，直接的个人中心是没有的
        self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    }
    
    self.gk_navRightBarButtonItems = @[self.shareBtnItem];

    self.inputview.alpha = 1;
    self.tableView.alpha = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)simulateServer{
    JobsIMChatInfoModel *chatInfoModel = JobsIMChatInfoModel.new;
    chatInfoModel.senderChatTextStr = @"我是马化腾,明天来上班";//tony马，明天我可以来上班吗？
    chatInfoModel.senderChatTextTimeStr = [NSString getSysTimeStamp];
    chatInfoModel.senderChatUserIconIMG = KBuddleIMG(@"⚽️PicResource", @"头像", nil, @"头像_2");//我自己的头像
    chatInfoModel.identification = @"我是服务器";
    
    [self.chatInfoModelMutArr addObject:chatInfoModel];
    [self.tableView reloadData];
}

#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JobsIMChatInfoTBVCell cellHeightWithModel:self.chatInfoModelMutArr[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.chatInfoModelMutArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JobsIMChatInfoTBVCell *cell = [JobsIMChatInfoTBVCell cellWith:tableView];
    cell.contentView.backgroundColor = RandomColor;
    cell.indexPath = indexPath;
    [cell richElementsInCellWithModel:self.chatInfoModelMutArr[indexPath.row]];
    return cell;
}
#pragma mark —— lazyLoad
-(JobsIMInputview *)inputview{
    if (!_inputview) {
        _inputview = JobsIMInputview.new;
        @weakify(self)
        [_inputview actionBlockJobsIMInputview:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:ZYTextField.class]){
                ZYTextField *tf = (ZYTextField *)data;
                
                JobsIMChatInfoModel *chatInfoModel = JobsIMChatInfoModel.new;
                chatInfoModel.senderChatTextStr = tf.text;
                chatInfoModel.senderChatTextTimeStr = [NSString getSysTimeStamp];
                chatInfoModel.senderChatUserIconIMG = KBuddleIMG(@"⚽️PicResource", @"头像", nil, @"头像_1");//我自己的头像
                chatInfoModel.identification = @"我是我自己";
                
                [self.chatInfoModelMutArr addObject:chatInfoModel];
                [self.tableView reloadData];
                
                [self simulateServer];
                
            }else{}
        }];
        [self.view addSubview:_inputview];
        [_inputview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(JobsIMInputviewHeight());
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-BottomSafeAreaHeight());
        }];
    }return _inputview;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = HEXCOLOR(0x242A37);
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.mj_footer.automaticallyHidden = NO;//默认根据数据来源 自动显示 隐藏footer，这个功能可以关闭
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(Top());
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.inputview.mas_top);
        }];
        [self.view layoutIfNeeded];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0 ;
        _tableView.mj_header = MJRefreshWithLottieTableViewHeader.new;
        _tableView.mj_footer.hidden = NO;
    }return _tableView;
}

-(NSMutableArray<JobsIMChatInfoModel *> *)chatInfoModelMutArr{
    if (!_chatInfoModelMutArr) {
        _chatInfoModelMutArr = NSMutableArray.array;
    }return _chatInfoModelMutArr;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = UIButton.new;
        _shareBtn.mj_w = 23;
        _shareBtn.mj_h = 23;
        [_shareBtn setImage:KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"分享") forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [UIView cornerCutToCircleWithView:_shareBtn AndCornerRadius:23 / 2];
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"分享功能");
        }];
    }return _shareBtn;
}

-(UIBarButtonItem *)shareBtnItem{
    if (!_shareBtnItem) {
        _shareBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    }return _shareBtnItem;
}

@end
