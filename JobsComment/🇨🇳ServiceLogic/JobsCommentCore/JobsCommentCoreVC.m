//
//  JobsCommentCoreVC.m
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import "JobsCommentCoreVC.h"
#import "JobsCommentCoreVC+VM.h"

@interface JobsCommentCoreVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)JobsCommentTitleHeaderView *titleHeaderView;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation JobsCommentCoreVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    self.gk_statusBarHidden = YES;
    self.gk_navigationBar.hidden = YES;
    [self loadData];
    self.titleHeaderView.alpha = 1;
    self.tableView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LoadMoreTBVCell cellHeightWithModel:nil];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 二级标题点击事件
    SYSAlertControllerConfig *config = SYSAlertControllerConfig.new;
    config.isSeparateStyle = YES;
    config.btnTitleArr = @[@"回复",@"复制",@"举报",@"取消"];
    config.alertBtnActionArr = @[@"reply",@"copyIt",@"report",@"cancel"];
    config.targetVC = self;
    config.funcInWhere = self;
    config.animated = YES;
    
    [NSObject showSYSActionSheetConfig:config
                          alertVCBlock:nil
                       completionBlock:nil];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{// 二级评论
    MKFirstCommentModel *firstCommentModel = (MKFirstCommentModel *)self.mjModel.listMutArr[section];
    MKFirstCommentCustomCofigModel *customCofigModel = MKFirstCommentCustomCofigModel.new;
    customCofigModel.childMutArr = firstCommentModel.childMutArr;
    return customCofigModel.firstShonNum;
}
//二级评论数据 展示在cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MKFirstCommentModel *firstCommentModel = (MKFirstCommentModel *)self.mjModel.listMutArr[indexPath.section];//一级评论数据 展示在viewForHeaderInSection
    MKChildCommentModel *childCommentModel = firstCommentModel.childMutArr[indexPath.row];//二级评论数据 展示在cellForRowAtIndexPath
    
    MKFirstCommentCustomCofigModel *customCofigModel = MKFirstCommentCustomCofigModel.new;
    customCofigModel.childMutArr = firstCommentModel.childMutArr;
    
    if (customCofigModel.isFullShow) {
        InfoTBVCell *cell = [InfoTBVCell cellWithTableView:tableView];
        [cell richElementsInCellWithModel:childCommentModel];
        @weakify(self)
        [cell actionBlockInfoTBVCell:^(id data) {
            @strongify(self)
        }];return cell;
    }else{
        if (indexPath.row <= customCofigModel.firstShonNum) {
            // 二级评论展示...
            InfoTBVCell *cell = [InfoTBVCell cellWithTableView:tableView];
            [cell richElementsInCellWithModel:childCommentModel];
            @weakify(self)
            [cell actionBlockInfoTBVCell:^(id data) {
                @strongify(self)
            }];return cell;
        }else{
            // 加载更多...
            LoadMoreTBVCell *cell = [LoadMoreTBVCell cellWithTableView:tableView];
            [cell richElementsInCellWithModel:nil];
            return cell;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mjModel.listMutArr.count;//一级评论
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return [JobsCommentPopUpViewForTVH viewForTableViewHeaderHeightWithModel:nil];
}
//一级评论数据 展示在viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    MKFirstCommentModel *firstCommentModel = self.mjModel.listMutArr[section];//一级评论数据 展示在viewForHeaderInSection
    JobsCommentPopUpViewForTVH *header = [[JobsCommentPopUpViewForTVH alloc] initWithReuseIdentifier:NSStringFromClass(JobsCommentPopUpViewForTVH.class) withData:firstCommentModel];
    @weakify(self)
    // 一级标题点击事件
    [header actionBlockTableViewHeaderView:^(id data) {
        @strongify(self)
        SYSAlertControllerConfig *config = SYSAlertControllerConfig.new;
        config.title = @"牛逼";
        config.message = @"哈哈哈";
        config.isSeparateStyle = NO;
        config.btnTitleArr = @[@"好的"];
        config.alertBtnActionArr = @[@""];
        config.targetVC = self;
        config.funcInWhere = self;
        config.animated = YES;
        
        [NSObject showSYSAlertViewConfig:config
                            alertVCBlock:nil
                         completionBlock:nil];
    }];
    [header actionBlockjobsCommentPopUpViewForTVHBlock:^(id data) {
        @strongify(self)
    }];return header;
}
///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    [self.tableView.mj_header endRefreshing];
//
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
//    [self.tableView reloadData];
    //特别说明：pagingEnabled = YES 在此会影响Cell的偏移量，原作者希望我们在这里临时关闭一下，刷新完成以后再打开
    self.tableView.pagingEnabled = NO;
    [self performSelector:@selector(delayMethods)
               withObject:nil
               afterDelay:2];
}

-(void)delayMethods{
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.pagingEnabled = YES;
}
#pragma mark —— lazyLoad
-(JobsCommentTitleHeaderView *)titleHeaderView{
    if (!_titleHeaderView) {
        _titleHeaderView = JobsCommentTitleHeaderView.new;
        @weakify(self)
        [_titleHeaderView actionBlockJobsCommentTitleHeaderViewBlock:^(id data) {
            @strongify(self)
            [self dismissViewControllerAnimated:YES
                                     completion:Nil];
        }];
        [self.view addSubview:_titleHeaderView];
        [_titleHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(50);
        }];
    }return _titleHeaderView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        // UITableViewStyleGrouped 取消悬停效果
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStyleGrouped];
        _tableView.backgroundColor = HEXCOLOR(0x242A37);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = self.mjRefreshGifHeader;
        _tableView.mj_footer = self.mjRefreshBackNormalFooter;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.mj_footer.hidden = NO;
        _tableView.tableFooterView = UIView.new;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, self.popUpHeight, 0);
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.ly_emptyView = [EmptyView emptyViewWithImageStr:@"Indeterminate Spinner - Small"
                                                          titleStr:@"没有评论"
                                                         detailStr:@"来发布第一条吧"];
        
        if (self.mjModel.listMutArr.count) {
            [_tableView ly_hideEmptyView];
        }else{
            [_tableView ly_showEmptyView];
        }

        @weakify(self)
        _tableView.mj_header = [LOTAnimationMJRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self)
            sleep(3);
            [self pullToRefresh];
        }];
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view);
            make.top.equalTo(self.titleHeaderView.mas_bottom);
        }];
    }return _tableView;
}

@end
