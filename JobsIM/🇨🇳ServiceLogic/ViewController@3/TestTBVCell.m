//
//  TestTBVCell.m
//  JobsIM
//
//  Created by Jobs on 2021/1/25.
//

#import "TestTBVCell.h"

@interface TestTBVCell ()
// UI
@property(nonatomic,strong)UIImageView *rankIMGV;
@property(nonatomic,strong)UILabel *rankLab;
@property(nonatomic,strong)UIImageView *userHeaderIMGV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)UIButton *attentionBtn;
// Data
@property(nonatomic,strong)MKRankListModel *rankListModel;

@end

@implementation TestTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    TestTBVCell *tableViewCell = (TestTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!tableViewCell) {
        tableViewCell = [[TestTBVCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                    reuseIdentifier:ReuseIdentifier];
//        [UIView cornerCutToCircleWithView:cell andCornerRadius:6];
    }return tableViewCell;
}

-(void)richElementsInCellWithModel:(MKRankListModel *_Nullable)model{
    NSLog(@"enenen = %ld",(long)model.rankStyle);
    self.rankListModel = model;
    if (model.indexPath.row == 0) {
        self.rankIMGV.image = KIMG(@"第一名");
    }else if (model.indexPath.row == 1){
        self.rankIMGV.image = KIMG(@"第二名");
    }else if (model.indexPath.row == 2){
        self.rankIMGV.image = KIMG(@"第三名");
    }else{
        self.rankLab.text = [NSString stringWithFormat:@"%ld",(model.indexPath.row + 1)];
        [self.rankLab sizeToFit];
    }
    
    [self.userHeaderIMGV sd_setImageWithURL:model.headImageURL placeholderImage:KIMG(@"替代头像")];
    self.attentionBtn.selected = model.attention.boolValue;
    self.titleLab.text = model.nickName;
    self.subTitleLab.text = [NSString stringWithFormat:@"获得%@枚抖币",model.goldNum.stringValue];
    
    switch (model.rankStyle) {
        case EarningsRank:{//收益排行
            NSMutableArray *tempDataMutArr = NSMutableArray.array;
            RichLabelDataStringsModel *title_1_Model = RichLabelDataStringsModel.new;
            RichLabelDataStringsModel *title_2_Model = RichLabelDataStringsModel.new;
            
            {
                title_1_Model.dataString = @"获得";
                
                RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
                richLabelFontModel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
                richLabelFontModel.range = NSMakeRange(0, title_1_Model.dataString.length);
                
                RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
                richLabelTextCorModel.cor = RGBCOLOR(89,86,122);
                richLabelTextCorModel.range = NSMakeRange(0, title_1_Model.dataString.length);
                
                title_1_Model.richLabelFontModel = richLabelFontModel;
                title_1_Model.richLabelTextCorModel = richLabelTextCorModel;
            }
            
            {
                title_2_Model.dataString = [NSString stringWithFormat:@"%@枚抖币",model.goldNum.stringValue];
                
                RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
                richLabelFontModel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
                richLabelFontModel.range = NSMakeRange(title_1_Model.dataString.length, title_2_Model.dataString.length);
                
                RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
                richLabelTextCorModel.cor = RGBCOLOR(255, 0, 0);
                richLabelTextCorModel.range = NSMakeRange(title_1_Model.dataString.length, title_2_Model.dataString.length);
                
                
                title_2_Model.richLabelFontModel = richLabelFontModel;
                title_2_Model.richLabelTextCorModel = richLabelTextCorModel;
            }
            
            [tempDataMutArr addObject:title_1_Model];
            [tempDataMutArr addObject:title_2_Model];
            
            self.subTitleLab.attributedText = [NSObject makeRichTextWithDataConfigMutArr:tempDataMutArr];
        }break;
        case ProduceRank:{//创作排行
            NSMutableArray *tempDataMutArr = NSMutableArray.array;
            RichLabelDataStringsModel *title_1_Model = RichLabelDataStringsModel.new;
            RichLabelDataStringsModel *title_2_Model = RichLabelDataStringsModel.new;
            
            {
                title_1_Model.dataString = @"上传了";
                
                RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
                richLabelFontModel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
                richLabelFontModel.range = NSMakeRange(0, title_1_Model.dataString.length);
                
                RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
                richLabelTextCorModel.cor = RGBCOLOR(89,86,122);
                richLabelTextCorModel.range = NSMakeRange(0, title_1_Model.dataString.length);
                
                title_1_Model.richLabelFontModel = richLabelFontModel;
                title_1_Model.richLabelTextCorModel = richLabelTextCorModel;
            }
            
            {
                title_2_Model.dataString = [NSString stringWithFormat:@"%@个作品",model.goldNum.stringValue];
                
                RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
                richLabelFontModel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
                richLabelFontModel.range = NSMakeRange(title_1_Model.dataString.length, title_2_Model.dataString.length);
                
                RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
                richLabelTextCorModel.cor = RGBCOLOR(255, 0, 0);
                richLabelTextCorModel.range = NSMakeRange(title_1_Model.dataString.length, title_2_Model.dataString.length);
                
                
                title_2_Model.richLabelFontModel = richLabelFontModel;
                title_2_Model.richLabelTextCorModel = richLabelTextCorModel;
            }
            
            [tempDataMutArr addObject:title_1_Model];
            [tempDataMutArr addObject:title_2_Model];
            
            self.subTitleLab.attributedText = [NSObject makeRichTextWithDataConfigMutArr:tempDataMutArr];
        }break;
            
        default:
            break;
    }
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 80;
}
#pragma mark —— lazyLoad
-(UIImageView *)rankIMGV{
    if (!_rankIMGV) {
        _rankIMGV = UIImageView.new;
        [self.contentView addSubview:_rankIMGV];
        [_rankIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(26, 30.5));
            make.left.equalTo(self.contentView).offset(12.5);
        }];
    }return _rankIMGV;
}

-(UILabel *)rankLab{
    if (!_rankLab) {
        _rankLab = UILabel.new;
        _rankLab.textAlignment = NSTextAlignmentCenter;
        _rankLab.textColor = kBlackColor;
        _rankLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [self.contentView addSubview:_rankLab];
        [_rankLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(12.5);
            make.size.mas_equalTo(CGSizeMake(26, 30.5));
        }];
    }return _rankLab;
}

-(UIImageView *)userHeaderIMGV{
    if (!_userHeaderIMGV) {
        _userHeaderIMGV = UIImageView.new;
        [self.contentView addSubview:_userHeaderIMGV];
        [_userHeaderIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(45.5, 45.5));
            if (_rankIMGV) {
                make.left.equalTo(self.rankIMGV.mas_right).offset(6.6);
            }else if (_rankLab){
                make.left.equalTo(self.rankLab.mas_right).offset(6.6);
            }else{}
        }];
    }return _userHeaderIMGV;
}

-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = UIButton.new;
        [_attentionBtn setImage:KIMG(@"未关注") forState:UIControlStateNormal];
        [_attentionBtn setImage:KIMG(@"已关注") forState:UIControlStateSelected];
        [self.contentView addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(75, 28.5));
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-16);
        }];
        [UIView cornerCutToCircleWithView:_attentionBtn andCornerRadius:28.5 / 2];
        
    }return _attentionBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
        _titleLab.textColor = RGBCOLOR(46, 51, 77);
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userHeaderIMGV.mas_right).offset(10.5);
            make.bottom.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.attentionBtn.mas_left).offset(-6.6);
        }];
    }return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        [self.contentView addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userHeaderIMGV.mas_right).offset(10.5);
            make.top.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.attentionBtn.mas_left).offset(-6.6);
        }];
    }return _subTitleLab;
}


@end
