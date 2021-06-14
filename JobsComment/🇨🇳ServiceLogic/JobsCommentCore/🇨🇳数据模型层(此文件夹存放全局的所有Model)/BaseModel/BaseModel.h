//
//  BaseModel.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/22.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

@property(nonatomic,copy)NSString *total;
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger size;
@property(nonatomic,copy)NSString *startRow;
@property(nonatomic,copy)NSString *endRow;
@property(nonatomic,assign)NSInteger pages;
@property(nonatomic,assign)NSInteger prePage;
@property(nonatomic,assign)NSInteger nextPage;
@property(nonatomic,assign)BOOL isFirstPage;
@property(nonatomic,assign)BOOL isLastPage;
@property(nonatomic,assign)BOOL hasPreviousPage;
@property(nonatomic,assign)BOOL hasNextPage;
@property(nonatomic,assign)NSInteger navigatePages;
@property(nonatomic,assign)NSArray *navigatepageNums;
@property(nonatomic,assign)NSInteger navigateFirstPage;
@property(nonatomic,assign)NSInteger navigateLastPage;

@end

NS_ASSUME_NONNULL_END
/*
     常用的解析方法:

     1、NSMutableArray *tags = [VideoTagModel mj_objectArrayWithKeyValuesArray:model.data]; //【对待data是数组】
     2、DDMyVipModel *myVipModel = [DDMyVipModel mj_objectWithKeyValues:data]; //【对待data是字典】
 */

/**
     例子：如果遇到【总数据Data】里面是数组,数组里面各种模型数组互相嵌套,如下所示👇

     Data = {
         msg = "success";
         data = (
             {
                 notes = "至尊永久卡，可传辈";
                 vipLevel = 4;
                 originalPrice = 29900;
                 price = 5000;
                 sid = "1";
                 seniorDetail = (
                     {
                         name = "动态优先审核";
                         icon = "";
                         code = "isDynamicCheck";
                     }
                 );
                 duration = 0;
                 name = "永久卡【限时2折】";
                 icon = "";
             }
         );
         code = 200;
     }

     设立model的时候需要把外层的 msg、code、data 一起解析

     具体的model为

     @interface DDMyVipModel : NSObject

     @property(nonatomic,copy)NSString *msg;
     @property(nonatomic,strong)NSArray <DDMyVipListModel *>*data;
     @property(nonatomic,copy)NSString *code;

     @end

     具体代码为：[DDMyVipModel mj_objectWithKeyValues:Data];

 **/

