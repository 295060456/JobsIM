//
//  InfoTBVCell.h
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+YBGIF.h"
#import "RBCLikeButton.h"
#import "JobsCommentConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoTBVCell : UITableViewCell

@property(nonatomic,strong)RBCLikeButton *LikeBtn;
@property(nonatomic,strong)MKChildCommentModel *childCommentModel;

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
- (void)richElementsInCellWithModel:(id _Nullable)model;
-(void)actionBlockInfoTBVCell:(MKDataBlock _Nullable)infoTBVCellBlock;

@end

NS_ASSUME_NONNULL_END
