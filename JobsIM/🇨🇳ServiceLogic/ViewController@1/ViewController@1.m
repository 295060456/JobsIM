//
//  ViewController@1.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "ViewController@1.h"
#import "JobsIMVC.h"
#import "JobsIMChatInfoModel.h"

@interface ViewController_1 ()

@end

@implementation ViewController_1

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    JobsIMChatInfoModel *chatInfoModel = JobsIMChatInfoModel.new;
    chatInfoModel.senderChatTextStr = @"我是马化腾,明天来上班";
    chatInfoModel.senderUserName = @"马化腾";
    chatInfoModel.senderChatTextTimeStr = [NSString getSysTimeStamp];
    chatInfoModel.senderChatUserIconIMG = KBuddleIMG(@"⚽️PicResource", @"头像", nil, @"头像_2");//我自己的头像
    chatInfoModel.identification = @"我是服务器";
    
    [UIViewController comingFromVC:self
                              toVC:JobsIMVC.new
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIModalPresentationAutomatic
                     requestParams:chatInfoModel
                           success:^(id data) {}
                          animated:YES];
}

@end
