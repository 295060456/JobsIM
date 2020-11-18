//
//  ViewController@1.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "ViewController@1.h"

@interface ViewController_1 ()

//
@property(nonatomic,strong)UIBarButtonItem *shareBtnItem;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)JobsIMListView *listView;

@end

@implementation ViewController_1

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    self.gk_navTitle = @"JobsIM";
    self.gk_navTitleColor = kRedColor;
    self.gk_navRightBarButtonItems = @[self.shareBtnItem];
    [self hideNavLine];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.listView.alpha = 1;
}

-(JobsIMListView *)listView{
    if (!_listView) {
        _listView = JobsIMListView.new;
        @weakify(self)
        [_listView actionBlockJobsIMListView:^(JobsIMListDataModel *data) {
            @strongify(self)
            
            JobsIMChatInfoModel *chatInfoModel = JobsIMChatInfoModel.new;
            chatInfoModel.senderChatTextStr = data.contentStr;
            chatInfoModel.senderUserNameStr = data.usernameStr;
            TimeModel *timeModel = TimeModel.new;
            [timeModel makeSpecificTime];
            chatInfoModel.senderChatTextTimeStr = [NSString stringWithFormat:@"%ld:%ld:%ld",timeModel.currentHour,timeModel.currentMin,timeModel.currentSec];
            chatInfoModel.senderChatUserIconIMG = data.userHeaderIMG;
            chatInfoModel.identification = @"我是服务器";
            
            [UIViewController comingFromVC:self
                                      toVC:JobsIMVC.new
                               comingStyle:ComingStyle_PUSH
                         presentationStyle:UIModalPresentationAutomatic
                             requestParams:chatInfoModel
                                   success:^(id data) {}
                                  animated:YES];
        }];
        [self.view addSubview:_listView];
        [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            if (self.gk_navBarAlpha && !self.gk_navigationBar.hidden) {//显示
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }else{
                make.top.equalTo(self.view.mas_top);
            }
        }];
    }return _listView;
}

-(UIBarButtonItem *)shareBtnItem{
    if (!_shareBtnItem) {
        _shareBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    }return _shareBtnItem;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = UIButton.new;
        _shareBtn.mj_w = 23;
        _shareBtn.mj_h = 23;
        [_shareBtn setImage:KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"PLUS") forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [UIView cornerCutToCircleWithView:_shareBtn AndCornerRadius:23 / 2];
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [NSObject showSYSAlertViewTitle:@"此功能尚在开发中..."
                                    message:@"敬请期待"
                            isSeparateStyle:NO
                                btnTitleArr:@[@"好的"]
                             alertBtnAction:@[@""]
                                   targetVC:self
                               alertVCBlock:^(id data) {
                //DIY
            }];
        }];
    }return _shareBtn;
}

@end
