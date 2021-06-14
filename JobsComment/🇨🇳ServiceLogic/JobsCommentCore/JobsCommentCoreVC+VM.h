//
//  JobsCommentCoreVC+VM.h
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import "JobsCommentCoreVC.h"

#if __has_include(<MJExtension/MJExtension.h>)
#import <MJExtension/MJExtension.h>
#else
#import "MJExtension.h"
#endif

#if __has_include(<YYModel/YYModel.h>)
#import <YYModel/YYModel.h>
#else
#import "YYModel.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface JobsCommentCoreVC (VM)

//装载本地假数据
-(void)loadData;

@end

NS_ASSUME_NONNULL_END
