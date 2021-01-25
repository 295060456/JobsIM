//
//  ViewController@2.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "ViewController@2.h"

@interface ViewController_2 (){
    BOOL d;
}

@property(nonatomic,strong)UIView *theView;
@property(nonatomic,strong)CAGradientLayer *gradientLayer;

@end

@implementation ViewController_2

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    
    //初始化我们需要改变背景色的UIView，并添加在视图上
    self.theView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:self.theView];
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.theView.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.theView.layer addSublayer:self.gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 1);
    
    //设置颜色数组
    self.gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor];
    
    //设置颜色分割点（范围：0-1）
    self.gradientLayer.locations = @[@(0.5f), @(1.0f)];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (!d) {
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = CGPointMake(0, 1);
        self.gradientLayer.colors = @[(__bridge id)[UIColor yellowColor].CGColor,
                                      (__bridge id)[UIColor greenColor].CGColor];
    }else{
        //设置颜色数组
        self.gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,
                                      (__bridge id)[UIColor redColor].CGColor];
    }
    d = !d;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
