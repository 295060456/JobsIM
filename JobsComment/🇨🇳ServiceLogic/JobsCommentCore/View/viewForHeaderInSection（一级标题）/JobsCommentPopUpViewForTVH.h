//
//  CommentPopUpNonHoveringHeaderView.h
//  My_BaseProj
//
//  Created by Jobs on 2020/10/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TableViewHeaderView.h"
#import "RBCLikeButton.h"
#import "UIImage+YBGIF.h"
#import "JobsCommentConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsCommentPopUpViewForTVH : TableViewHeaderView

@property(nonatomic,assign)long indexSection;

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                              withData:(id)data;
-(void)actionBlockjobsCommentPopUpViewForTVHBlock:(MKDataBlock _Nullable)jobsCommentPopUpViewForTVHBlock;
+(CGFloat)viewForTableViewHeaderHeightWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
