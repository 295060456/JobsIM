//
//  JobsCommentCoreVC+VM.m
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import "JobsCommentCoreVC+VM.h"

@implementation JobsCommentCoreVC (VM)
//装载本地假数据
-(void)loadData{
    
    NSDictionary *dics = @{
        @"qwe":@"好的",
        @"dfr":@"dd",
    };
    
    NSArray *dd = @[@"qwe",@"vtt"];
    
    NSDictionary *dic = [NSString readLocalFileWithName:@"CommentData"];
    self.mjModel = [MKCommentModel mj_objectWithKeyValues:dic[@"data"]];
    self.yyModel = [MKCommentModel yy_modelWithDictionary:dic[@"data"]];
    NSLog(@"%@",dics);
    NSLog(@"%@",dd);
}

@end
