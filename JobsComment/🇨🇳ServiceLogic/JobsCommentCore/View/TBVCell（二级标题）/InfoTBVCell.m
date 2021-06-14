//
//  InfoTBVCell.m
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "InfoTBVCell.h"

@interface InfoTBVCell ()

@property(nonatomic,copy)MKDataBlock infoTBVCellBlock;

@end

@implementation InfoTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    InfoTBVCell *cell = (InfoTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[InfoTBVCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = JobsCommentConfig.sharedInstance.bgCor;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return JobsCommentConfig.sharedInstance.cellHeight;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:MKChildCommentModel.class]) {
        self.childCommentModel = (MKChildCommentModel *)model;
        self.LikeBtn.selected = self.childCommentModel.isPraise.boolValue;
        self.LikeBtn.thumpNum = self.childCommentModel.praiseNum;
        self.textLabel.text = self.childCommentModel.nickname;
        self.detailTextLabel.text = self.childCommentModel.content;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.childCommentModel.headImg]
                          placeholderImage:[UIImage animatedGIFNamed:@"动态头像 尺寸126"]];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.size = JobsCommentConfig.sharedInstance.headerImageViewSize;//subTitleOffset
    [UIView cornerCutToCircleWithView:self.imageView
                      andCornerRadius:self.imageView.mj_h / 2];
    self.textLabel.font = JobsCommentConfig.sharedInstance.titleFont;
    self.detailTextLabel.font = JobsCommentConfig.sharedInstance.subTitleFont;
    self.textLabel.textColor = JobsCommentConfig.sharedInstance.titleCor;
    self.detailTextLabel.textColor = JobsCommentConfig.sharedInstance.subTitleCor;
    
    //因为二级评论和一级评论的控件之间存在一定的offset(向右偏)，故这里进行重写约束
    self.imageView.mj_x += JobsCommentConfig.sharedInstance.secondLevelCommentOffset;
    self.textLabel.mj_x += JobsCommentConfig.sharedInstance.secondLevelCommentOffset;
    self.detailTextLabel.mj_x += JobsCommentConfig.sharedInstance.secondLevelCommentOffset;
}

-(void)actionBlockInfoTBVCell:(MKDataBlock _Nullable)infoTBVCellBlock{
    self.infoTBVCellBlock = infoTBVCellBlock;
}
#pragma mark —— lazyLoad
-(RBCLikeButton *)LikeBtn{
    if (!_LikeBtn) {
        _LikeBtn = RBCLikeButton.new;
        [_LikeBtn setImage:KBuddleIMG(nil, @"RBCLikeButton", nil, @"day_like")
                  forState:UIControlStateNormal];
        [_LikeBtn setImage:KBuddleIMG(nil, @"RBCLikeButton", nil, @"day_like_red")
                   forState:UIControlStateSelected];
//        _LikeBtn.layer.cornerRadius = SCALING_RATIO(55 / 4);
//        _LikeBtn.layer.borderColor = kGrayColor.CGColor;
//        _LikeBtn.layer.borderWidth = 1;
        _LikeBtn.thumpNum = 0;
        @weakify(self)
        [[_LikeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.infoTBVCellBlock) {
                self.infoTBVCellBlock(x);
            }
            
            if (self->_LikeBtn.selected) {
                [self->_LikeBtn setThumbWithSelected:NO
                                            thumbNum:self->_LikeBtn.thumpNum - 1
                                     animation:YES];
            }else{
                [self->_LikeBtn setThumbWithSelected:YES
                                            thumbNum:self->_LikeBtn.thumpNum + 1
                                     animation:YES];
            }
        }];
        [self.contentView addSubview:_LikeBtn];
        [_LikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55 / 2, 55 / 2));
            make.right.equalTo(self.contentView).offset(-13);
            make.centerY.equalTo(self.contentView);
        }];
    }return _LikeBtn;
}



@end
