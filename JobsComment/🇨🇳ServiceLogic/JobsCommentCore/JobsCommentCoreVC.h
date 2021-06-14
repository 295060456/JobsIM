 //
//  JobsCommentCoreVC.h
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import <UIKit/UIKit.h>
#import "PopUpVC.h"
#import "EmptyView.h"
#import "JobsCommentPopUpViewForTVH.h"
#import "JobsCommentTitleHeaderView.h"
#import "InfoTBVCell.h"//显示具体的有用讯息
#import "LoadMoreTBVCell.h"//加载更多
#import "LOTAnimationMJRefreshHeader.h"
#import "JobsCommentConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsCommentCoreVC : PopUpVC

//用下面两个都可以
@property(nonatomic,strong)MKCommentModel *mjModel;
@property(nonatomic,strong)MKCommentModel *yyModel;

@end

NS_ASSUME_NONNULL_END
