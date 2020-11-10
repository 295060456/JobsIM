//
//  JobsIMChatInfoTBVCell.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "JobsIMChatInfoTBVCell.h"

static inline CGFloat JobsIMChatInfoTBVCellHeight(){
    return 50;
}

@interface JobsIMChatInfoTBVCell ()

@end

@implementation JobsIMChatInfoTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    JobsIMChatInfoTBVCell *cell = (JobsIMChatInfoTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[JobsIMChatInfoTBVCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
////        cell.contentView.backgroundColor = RandomColor;
//        cell.imageView.image = KIMG(@"放大镜");
//        cell.tapGR.enabled = YES;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return JobsIMChatInfoTBVCellHeight();
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSString.class]) {
        self.textLabel.text = (NSString *)model;
    }
}

@end
