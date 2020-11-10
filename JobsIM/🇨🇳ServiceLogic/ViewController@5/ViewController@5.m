//
//  ViewController@5.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "ViewController@5.h"

@interface ViewController_5 ()

@end

@implementation ViewController_5

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

@end
