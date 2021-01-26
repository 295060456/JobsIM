//
//  JobsMarqueeContentCustomView.m
//  JobsIM
//
//  Created by Jobs on 2021/1/26.
//

#import "JobsMarqueeContentCustomView.h"

@interface JobsMarqueeContentCustomView ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIView *view;

@end

@implementation JobsMarqueeContentCustomView

-(void)richElementsWithModel:(id _Nullable)model{
    self.imageView.alpha = 1;
    self.contentLab.alpha = 1;
    self.view.alpha = 1;
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.backgroundColor = kRedColor;
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(5, 5));
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
        }];
    }return _imageView;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = UILabel.new;
        _contentLab.backgroundColor = kWhiteColor;
        _contentLab.text = @"hdejhi";
        _contentLab.textColor = kBlueColor;
        [self addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.imageView.mas_right).offset(10);
        }];
    }return _contentLab;
}

-(UIView *)view{
    if (!_view) {
        _view = UIView.new;
        _view.backgroundColor = KYellowColor;
        [self addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.left.equalTo(self.contentLab.mas_right).offset(10);
            make.centerY.equalTo(self);
        }];
    }return _view;
}

@end
