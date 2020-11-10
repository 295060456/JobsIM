//
//  JobsIMChatInfoTBVCell.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "JobsIMChatInfoTBVCell.h"
#import "JobsIMChatInfoModel.h"

static inline CGFloat JobsIMChatInfoTBVDefaultCellHeight(){
    return 50;
}

static inline CGFloat JobsIMChatInfoTBVChatContentLabWidth(){
    return MAINSCREEN_WIDTH - 80 - (JobsIMChatInfoTBVDefaultCellHeight() - 5) - 20;
}

static inline CGFloat JobsIMChatInfoTBVChatContentLabDefaultWidth(){
    return 100;
}

@interface JobsIMChatInfoTBVCell ()

@property(nonatomic,strong)UIImageView *iconIMGV;//用户头像
@property(nonatomic,strong)UIImageView *chatBubbleIMGV;//聊天气泡
@property(nonatomic,strong)UILabel *chatContentLab;//聊天信息承接
@property(nonatomic,strong)UILabel *timeLab;

@property(nonatomic,assign)InfoLocation infoLocation;
@property(nonatomic,strong)NSMutableArray <UIImage *>*chatBubbleMutArr;
//data
@property(nonatomic,strong)NSString *chatTextStr;//该聊天的文本信息
@property(nonatomic,strong)NSString *chatTextTimeStr;//该聊天的时间戳
@property(nonatomic,strong)UIImage *chatUserIconIMG;//该聊天的用户头像
@property(nonatomic,strong)NSString *identification;//该聊天对应的数据库坐标ID
@property(nonatomic,assign)CGFloat contentHeight;//内容高
@property(nonatomic,assign)CGFloat contentWidth;//内容宽

@end

@implementation JobsIMChatInfoTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    JobsIMChatInfoTBVCell *cell = (JobsIMChatInfoTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[JobsIMChatInfoTBVCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    if ([model isKindOfClass:JobsIMChatInfoModel.class]){
        JobsIMChatInfoModel *chatInfoModel = (JobsIMChatInfoModel *)model;
        CGFloat CellHeight = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                      calcLabelHeight_Width:CalcLabelHeight
                                                                               effectString:chatInfoModel.chatTextStr
                                                                                       font:NULL
                                                               boundingRectWithHeight_Width:JobsIMChatInfoTBVChatContentLabWidth()];
        NSLog(@"%f",CellHeight);
        return (CellHeight < JobsIMChatInfoTBVDefaultCellHeight() ? JobsIMChatInfoTBVDefaultCellHeight() : CellHeight) + (JobsIMChatInfoTBVDefaultCellHeight() - 5);
    }else{
        return 0;
    }
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:JobsIMChatInfoModel.class]) {
        JobsIMChatInfoModel *chatInfoModel = (JobsIMChatInfoModel *)model;
        if ([chatInfoModel.identification isEqualToString:@"我是服务器"]) {//对方发的消息
            self.infoLocation = InfoLocation_Left;
        }else if ([chatInfoModel.identification isEqualToString:@"我是我自己"]){//自己发的消息
            self.infoLocation = InfoLocation_Right;
        }else{
            self.infoLocation = InfoLocation_Unknown;
        }
        
        self.chatTextStr = chatInfoModel.chatTextStr;
        self.chatTextTimeStr = chatInfoModel.chatTextTimeStr;
        self.chatUserIconIMG = chatInfoModel.chatUserIconIMG;
        self.identification = chatInfoModel.identification;
        
        //先定宽，再定高
        
        CGFloat contentWidthTemp = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                            calcLabelHeight_Width:CalcLabelWidth
                                                                                     effectString:self.chatTextStr
                                                                                             font:NULL
                                                                     boundingRectWithHeight_Width:JobsIMChatInfoTBVDefaultCellHeight()];
        //保证最小宽度 且 小于最大宽度
        self.contentWidth = MIN(JobsIMChatInfoTBVChatContentLabWidth(), MAX(JobsIMChatInfoTBVChatContentLabDefaultWidth(), contentWidthTemp));
        
        self.contentHeight = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                   calcLabelHeight_Width:CalcLabelHeight
                                                                            effectString:self.chatTextStr
                                                                                    font:NULL
                                                            boundingRectWithHeight_Width:self.contentWidth];
        

        NSLog(@"contentHeight = %f",self.contentHeight);
        NSLog(@"contentWidth = %f",self.contentWidth);
        
        self.iconIMGV.alpha = 1;
        self.chatBubbleIMGV.alpha = 1;
        self.chatContentLab.alpha = 1;
        self.timeLab.alpha= 1;
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)iconIMGV{
    if (!_iconIMGV) {
        _iconIMGV = UIImageView.new;
        _iconIMGV.image = self.chatUserIconIMG;
        [self.contentView addSubview:_iconIMGV];
        [_iconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsIMChatInfoTBVDefaultCellHeight() - 5, JobsIMChatInfoTBVDefaultCellHeight() - 5));
            make.top.equalTo(self.contentView).offset(5);
            
            switch (self.infoLocation) {
                case InfoLocation_Left:{
                    make.left.equalTo(self.contentView).offset(10);
                }break;
                case InfoLocation_Right:{
                    make.right.equalTo(self.contentView).offset(-10);
                }break;
                default:
                    break;
            }
        }];
    }return _iconIMGV;
}

-(UIImageView *)chatBubbleIMGV{
    if (!_chatBubbleIMGV) {
        _chatBubbleIMGV = UIImageView.new;
        
        switch (self.infoLocation) {
            case InfoLocation_Left:{
                _chatBubbleIMGV.image = self.chatBubbleMutArr[0];
            }break;
            case InfoLocation_Right:{
                _chatBubbleIMGV.image = self.chatBubbleMutArr[1];
            }break;
            default:
                break;
        }
        
        [self.contentView addSubview:_chatBubbleIMGV];
        [_chatBubbleIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.iconIMGV.mas_centerY);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.width.mas_equalTo(self.contentWidth);
            
            switch (self.infoLocation) {
                case InfoLocation_Left:{
                    make.left.equalTo(self.iconIMGV.mas_right).offset(5);
                    
                }break;
                case InfoLocation_Right:{
                    make.right.equalTo(self.iconIMGV.mas_left).offset(-5);
                }break;
                default:
                    break;
            }
        }];
    }return _chatBubbleIMGV;
}

-(UILabel *)chatContentLab{
    if (!_chatContentLab) {
        _chatContentLab = UILabel.new;
        _chatContentLab.numberOfLines = 0;
        _chatContentLab.textColor = kBlackColor;
        _chatContentLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        _chatContentLab.textAlignment = NSTextAlignmentCenter;
        _chatContentLab.text = self.chatTextStr;
        [self.chatBubbleIMGV addSubview:_chatContentLab];
        [_chatContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.chatBubbleIMGV).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
    }return _chatContentLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.text = self.chatTextTimeStr;
        _timeLab.textColor = kWhiteColor;
        _timeLab.backgroundColor = KLightGrayColor;
        [_timeLab sizeToFit];
        
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.chatBubbleIMGV);
            make.size.mas_equalTo(CGSizeMake(80, 20));
            
            switch (self.infoLocation) {
                case InfoLocation_Left:{
                    make.left.equalTo(self.chatBubbleIMGV.mas_right).offset(5);
                }break;
                case InfoLocation_Right:{
                    make.right.equalTo(self.chatBubbleIMGV.mas_left).offset(-5);
                }break;
                default:
                    break;
            }
        }];
        [UIView cornerCutToCircleWithView:_timeLab AndCornerRadius:20 / 2];
    }return _timeLab;
}

-(NSMutableArray<UIImage *> *)chatBubbleMutArr{
    if (!_chatBubbleMutArr) {
        _chatBubbleMutArr = NSMutableArray.array;
        [_chatBubbleMutArr addObject:KIMG(@"左气泡")];//左气泡
        [_chatBubbleMutArr addObject:KIMG(@"右气泡")];//右气泡
    }return _chatBubbleMutArr;
}

@end
