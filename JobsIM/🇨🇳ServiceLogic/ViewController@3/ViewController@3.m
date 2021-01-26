//
//  ViewController@3.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "ViewController@3.h"
#import "TestTBVCell.h"

@interface ViewController_3 ()
<UITableViewDelegate,
UITableViewDataSource
>
// UI
@property(nonatomic,strong)UITableView *tableView;
// Data
@property(nonatomic,strong)NSMutableArray <MKRankListModel *>*dataMutArr;

@end

@implementation ViewController_3

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    self.tableView.alpha = 1;//[self->tableView tab_endAnimation];//里面实现了 [self->tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TestTBVCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TestTBVCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];

}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestTBVCell *tableViewCell = [TestTBVCell cellWithTableView:tableView];
    [tableViewCell richElementsInCellWithModel:nil];
    return tableViewCell;
}
#pragma mark - Lazy Methods
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        {// 设置tabAnimated相关属性
            // 可以不进行手动初始化，将使用默认属性
            _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:TestTBVCell.class
                                                                  cellHeight:[TestTBVCell cellHeightWithModel:nil]];
            _tableView.tabAnimated.superAnimationType = TABViewSuperAnimationTypeShimmer;
            [_tableView tab_startAnimation];   // 开启动画
        }
    }return _tableView;
}

-(NSMutableArray<MKRankListModel *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
    }return _dataMutArr;
}

@end
