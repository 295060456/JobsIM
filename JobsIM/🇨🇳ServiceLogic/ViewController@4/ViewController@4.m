//
//  ViewController@4.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "ViewController@4.h"

#import "JobsMarqueeView.h"
#import "JobsMarqueeContentCustomView.h"

@interface ViewController_4 ()

@end

@implementation ViewController_4

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    
//    {
//        JobsMarqueeConfig *marqueeConfig = JobsMarqueeConfig.new;
//        marqueeConfig.contentText = @"hahahah";
//        marqueeConfig.duration = 2;
//        marqueeConfig.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
//    //    marqueeConfig.direction = JobsMarqueeDirectionStyleTop;
//    //    marqueeConfig.direction = JobsMarqueeDirectionStyleDown;
//    //    marqueeConfig.direction = JobsMarqueeDirectionStyleLeft;
//        marqueeConfig.direction = JobsMarqueeDirectionStyleRight;
//
//        JobsMarqueeView *textView = [[JobsMarqueeView alloc] initWithFrame:CGRectMake(30, 500, self.view.bounds.size.width-60, 20)];
//        textView.backgroundColor = kRedColor;
//        [textView richElementsWithModel:marqueeConfig];
//
//        [self.view addSubview:textView];
//    }
    
    {
        JobsMarqueeConfig *marqueeConfig = JobsMarqueeConfig.new;
//        marqueeConfig.contentText = @"hahahah";
        marqueeConfig.duration = 2;
//        marqueeConfig.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
    //    marqueeConfig.direction = JobsMarqueeDirectionStyleTop;
    //    marqueeConfig.direction = JobsMarqueeDirectionStyleDown;
    //    marqueeConfig.direction = JobsMarqueeDirectionStyleLeft;
        marqueeConfig.direction = JobsMarqueeDirectionStyleRight;
        
        JobsMarqueeView *textView = [[JobsMarqueeView alloc] initWithFrame:CGRectMake(30, 500, self.view.bounds.size.width-60, 20)];
        textView.backgroundColor = kRedColor;
        [textView richElementsWithModel:marqueeConfig
                             customView:^(UIView *data) {
            JobsMarqueeContentCustomView *marqueeContentCustomView = JobsMarqueeContentCustomView.new;
//            marqueeContentCustomView.backgroundColor = kBlueColor;
            [marqueeContentCustomView richElementsWithModel:nil];
            [data addSubview:marqueeContentCustomView];
            [marqueeContentCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(data);
            }];
        }];
        
        [self.view addSubview:textView];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
