//
//  CommentPopUpNonHoveringHeaderView.m
//  My_BaseProj
//
//  Created by Jobs on 2020/10/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsCommentPopUpViewForTVH.h"

@interface JobsCommentPopUpViewForTVH ()

@property(nonatomic,strong)UIImageView *headerIMGV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)RBCLikeButton *LikeBtn;

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)MKFirstCommentModel *firstCommentModel;
@property(nonatomic,copy)MKDataBlock jobsCommentPopUpViewForTVHBlock;

@end

@implementation JobsCommentPopUpViewForTVH

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                              withData:(id)data{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = JobsCommentConfig.sharedInstance.bgCor;
        if ([data isKindOfClass:MKFirstCommentModel.class]) {
            self.firstCommentModel = (MKFirstCommentModel *)data;
            [self.headerIMGV sd_setImageWithURL:[NSURL URLWithString:self.firstCommentModel.headImg]
                               placeholderImage:[UIImage animatedGIFNamed:@"动态头像 尺寸126"]];
            self.titleStr = self.firstCommentModel.nickname;
            self.contentStr = self.firstCommentModel.content;
            self.titleLab.alpha = 1;
            self.contentLab.alpha = 1;
            self.LikeBtn.selected = self.firstCommentModel.isPraise;
        }
    }return self;
}

+(CGFloat)viewForTableViewHeaderHeightWithModel:(id _Nullable)model{
    return JobsCommentConfig.sharedInstance.cellHeight;
}

-(void)actionBlockjobsCommentPopUpViewForTVHBlock:(MKDataBlock _Nullable)jobsCommentPopUpViewForTVHBlock{
    self.jobsCommentPopUpViewForTVHBlock = jobsCommentPopUpViewForTVHBlock;
}
#pragma mark —— lazyLoad
-(UIImageView *)headerIMGV{
    if (!_headerIMGV) {
        _headerIMGV = UIImageView.new;
        [self.contentView addSubview:_headerIMGV];
        [_headerIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(JobsCommentConfig.sharedInstance.headerImageViewSize);
            make.left.equalTo(self.contentView).offset(16);
            make.centerY.equalTo(self.contentView);
        }];
    }return _headerIMGV;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.attributedText = [[NSMutableAttributedString alloc] initWithString:self.titleStr
                                                                          attributes:@{NSFontAttributeName: JobsCommentConfig.sharedInstance.titleFont,
                                                                                       NSForegroundColorAttributeName: JobsCommentConfig.sharedInstance.titleCor}];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.headerIMGV.mas_centerY);
            make.left.equalTo(self.headerIMGV.mas_right).offset(10);
        }];
    }return _titleLab;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = UILabel.new;
        _contentLab.text = self.contentStr;
        _contentLab.attributedText = [[NSMutableAttributedString alloc] initWithString:self.contentStr
                                                                            attributes: @{NSFontAttributeName: JobsCommentConfig.sharedInstance.subTitleFont,
                                                                                          NSForegroundColorAttributeName: JobsCommentConfig.sharedInstance.subTitleCor}];
        [self.contentView addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_centerY);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.headerIMGV.mas_right).offset(10);
        }];
    }return _contentLab;
}

-(RBCLikeButton *)LikeBtn{
    if (!_LikeBtn) {
        _LikeBtn = RBCLikeButton.new;
        [_LikeBtn setImage:KBuddleIMG(nil,
                                      @"RBCLikeButton",
                                      nil,
                                      @"day_like")
                  forState:UIControlStateNormal];
        [_LikeBtn setImage:KBuddleIMG(nil,
                                      @"RBCLikeButton",
                                      nil,
                                      @"day_like_red")
                   forState:UIControlStateSelected];
//        _LikeBtn.layer.cornerRadius = SCALING_RATIO(55 / 4);
//        _LikeBtn.layer.borderColor = kGrayColor.CGColor;
//        _LikeBtn.layer.borderWidth = 1;
        _LikeBtn.thumpNum = 0;
        @weakify(self)
        [[_LikeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.jobsCommentPopUpViewForTVHBlock) {
                self.jobsCommentPopUpViewForTVHBlock(x);
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
            make.size.mas_equalTo(CGSizeMake(JobsCommentConfig.sharedInstance.cellHeight / 2, JobsCommentConfig.sharedInstance.cellHeight / 2));
            make.right.equalTo(self.contentView).offset(-13);
            make.centerY.equalTo(self.contentView);
        }];
    }return _LikeBtn;
}

@end
