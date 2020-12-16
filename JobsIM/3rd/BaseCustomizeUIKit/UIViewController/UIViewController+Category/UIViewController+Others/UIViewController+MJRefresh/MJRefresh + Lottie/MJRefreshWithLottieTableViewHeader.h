//
//  TestHeader.h
//  lottieDemo
//
//  Created by Lindashuai on 2020/1/19.
//  Copyright © 2020 Lindashuai. All rights reserved.
//

#import "MJRefreshGifHeader.h"
#import "MJRefreshComponent+Lottie.h"

@interface MJRefreshWithLottieTableViewHeader : MJRefreshGifHeader

-(void)endRefreshing;
-(void)actionBlockMJRefreshWithLottieTableViewHeader:(MKDataBlock _Nullable)mjRefreshWithLottieTableViewHeaderBlock;

@end

/*
#pragma mark —— tableView
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = UITableView.new;
        _tableView.frame = self.view.bounds;
        _tableView.backgroundColor = kGrayColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_header = TestTableViewHeader.new;//self.mjRefreshGifHeader;//
        _tableView.mj_header.jsonString = @"12345.json";
        [self.view addSubview:_tableView];
    }return _tableView;
}
*/
