//
//  JobsIMChatInfoModel.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobsIMChatInfoModel : NSObject

//消息的发送者
@property(nonatomic,strong,nullable)NSString *senderUserID;//发出该聊天的用户ID
@property(nonatomic,strong,nullable)NSString *senderUserName;//发出该聊天的用户名
@property(nonatomic,strong,nullable)UIImage *senderChatUserIconIMG;//发出该聊天的用户头像
@property(nonatomic,strong,nullable)NSString *senderChatUserIconURLStr;//发出该聊天的用户头像地址
@property(nonatomic,strong,nullable)NSString *senderChatTextStr;//发出该聊天的文本信息
@property(nonatomic,strong,nullable)NSString *senderChatTextTimeStr;//发出该聊天的时间戳
//消息的接受者
@property(nonatomic,strong,nullable)NSString *receiverUserID;//接受该聊天的用户ID
@property(nonatomic,strong,nullable)NSString *receiverUserName;//接受该聊天的用户名
@property(nonatomic,strong,nullable)UIImage *receiverChatUserIconIMG;//接受该聊天的用户头像
@property(nonatomic,strong,nullable)NSString *receiverChatUserIconURLStr;//接受该聊天的用户头像地址
//全局ID
@property(nonatomic,strong,nullable)NSString *identification;//该聊天对应的数据库坐标ID

@end

NS_ASSUME_NONNULL_END
