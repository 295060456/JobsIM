//
//  ViewController@1.m
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import "ViewController@1.h"
#import "UIWindow+Touch.h"
#import "JobsCommentCoreVC.h"

PopUpVC *popUpVC;
JobsCommentCoreVC *jobsCommentCoreVC;

@interface ViewController_1 ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIPanGestureRecognizer *panGR;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeGRUp;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeGRDown;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeGRLeft;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeGRRight;

@end

@implementation ViewController_1

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    
    self.panGR.enabled = YES;
    self.swipeGRUp.enabled = YES;
    self.swipeGRDown.enabled = YES;
    self.swipeGRLeft.enabled = YES;
    self.swipeGRRight.enabled = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
//    {    //触发
//        popUpVC = PopUpVC.new;
//    //        @weakify(self)
//        [popUpVC actionBlockPopUpVC:^(id data) {
//    //            @strongify(self)
//            NSLog(@"您点击了关注");
//        }];
//        [UIViewController comingFromVC:self
//                                  toVC:popUpVC
//                           comingStyle:ComingStyle_PRESENT
//                     presentationStyle:UIModalPresentationAutomatic
//                         requestParams:@""
//                               success:^(id data) {}
//                              animated:YES];
//    }
    
    {    //触发
        jobsCommentCoreVC = JobsCommentCoreVC.new;
    //        @weakify(self)
        [jobsCommentCoreVC actionBlockPopUpVC:^(id data) {
    //            @strongify(self)
            NSLog(@"您点击了关注");
        }];

        [UIViewController comingFromVC:self
                                  toVC:jobsCommentCoreVC
                           comingStyle:ComingStyle_PUSH
                     presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                         requestParams:@""
              hidesBottomBarWhenPushed:YES
                              animated:YES
                               success:^(id data) {
            
        }];
    }
}
//拖拽手势
-(void)panGR:(UIPanGestureRecognizer *)panGR{
    
}

-(void)swipeGRDirectionUP:(UISwipeGestureRecognizer *)swipeGR{
    
}

-(void)swipeGRDirectionDOWN:(UISwipeGestureRecognizer *)swipeGR{
    
}

-(void)swipeGRDirectionLEFT:(UISwipeGestureRecognizer *)swipeGR{
    
}

-(void)swipeGRDirectionRIGHT:(UISwipeGestureRecognizer *)swipeGR{
    
}

#pragma mark - UIGestureRecognizerDelegate
//每次走2次
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
      shouldReceiveTouch:(UITouch *)touch{
//    NSLog(@"shouldReceiveTouch");
    return YES;
}
//是否接收一个手势触摸事件，默认为YES，返回NO为不接收
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)GR{
    return YES;
}
#pragma mark —— lazyLoad
-(UIPanGestureRecognizer *)panGR{
    if (!_panGR) {
        _panGR = UIPanGestureRecognizer.new;
        [_panGR addTarget:self action:@selector(panGR:)];
        _panGR.minimumNumberOfTouches = 1;//default = 1
        [self.view addGestureRecognizer:_panGR];
        _panGR.delegate = self;
    }return _panGR;
}

-(UISwipeGestureRecognizer *)swipeGRUp{
    if (!_swipeGRUp) {
        _swipeGRUp = UISwipeGestureRecognizer.new;
        [_swipeGRUp addTarget:self action:@selector(swipeGRDirectionUP:)];
        _swipeGRUp.direction = UISwipeGestureRecognizerDirectionUp;
        _swipeGRUp.delegate = self;
        [self.view addGestureRecognizer:_swipeGRUp];
    }return _swipeGRUp;
}

-(UISwipeGestureRecognizer *)swipeGRDown{
    if (!_swipeGRDown) {
        _swipeGRDown = UISwipeGestureRecognizer.new;
        [_swipeGRUp addTarget:self action:@selector(swipeGRDirectionDOWN:)];
        _swipeGRDown.direction = UISwipeGestureRecognizerDirectionDown;
        _swipeGRDown.delegate = self;
        [self.view addGestureRecognizer:_swipeGRDown];
    }return _swipeGRDown;
}

-(UISwipeGestureRecognizer *)swipeGRLeft{
    if (!_swipeGRLeft) {
        _swipeGRLeft = UISwipeGestureRecognizer.new;
        [_swipeGRUp addTarget:self action:@selector(swipeGRDirectionLEFT:)];
        _swipeGRLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        _swipeGRLeft.delegate = self;
        [self.view addGestureRecognizer:_swipeGRLeft];
    }return _swipeGRLeft;
}

-(UISwipeGestureRecognizer *)swipeGRRight{
    if (!_swipeGRRight) {
        _swipeGRRight = UISwipeGestureRecognizer.new;
        [_swipeGRUp addTarget:self action:@selector(swipeGRDirectionRIGHT:)];
        _swipeGRRight.direction = UISwipeGestureRecognizerDirectionRight;
        _swipeGRRight.delegate = self;
        [self.view addGestureRecognizer:_swipeGRRight];
    }return _swipeGRRight;
}

@end
