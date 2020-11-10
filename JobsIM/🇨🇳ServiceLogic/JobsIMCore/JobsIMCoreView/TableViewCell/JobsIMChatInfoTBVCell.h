//
//  JobsIMChatInfoTBVCell.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import "TBVCell_style_02.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsIMChatInfoTBVCell : TBVCell_style_02

+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
