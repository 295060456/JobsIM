//
//  JobsIMChatInfoTBVCell.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+Margin.h"

NS_ASSUME_NONNULL_BEGIN

/** 消息显示位置 */
typedef NS_ENUM(NSInteger,InfoLocation) {
    InfoLocation_Unknown = 0,
    InfoLocation_Left = 1,
    InfoLocation_Right = 2
};

@interface JobsIMChatInfoTBVCell : UITableViewCell

@property(nonatomic,assign)BOOL isShowChatUserName;//是否显示每一个聊天的用户的用户名？默认不显示

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
