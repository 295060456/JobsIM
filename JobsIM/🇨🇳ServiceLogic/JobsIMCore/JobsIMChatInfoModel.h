//
//  JobsIMChatInfoModel.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobsIMChatInfoModel : NSObject

@property(nonatomic,strong)NSString *chatTextStr;//该聊天的文本信息
@property(nonatomic,strong)NSString *chatTextTimeStr;//该聊天的时间戳
@property(nonatomic,strong)UIImage *chatUserIconIMG;//该聊天的用户头像
@property(nonatomic,strong)NSString *identification;//该聊天对应的数据库坐标ID

@end

NS_ASSUME_NONNULL_END
