//
//  JobsMarqueeView.m
//  JobsIM
//
//  Created by Jobs on 2021/1/26.
//

#import "JobsMarqueeView.h"

@implementation JobsMarqueeConfig

@end

@interface JobsMarqueeView ()

@property(nonatomic,strong)UIView *contentView;//帧动画的作用对象，所有的子控件都添加于此，而不是self
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)CAKeyframeAnimation *keyFrame;

@end

@implementation JobsMarqueeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.alpha = 1;
        self.layer.masksToBounds = YES;
    }return self;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
}

-(void)richElementsWithModel:(JobsMarqueeConfig *_Nullable)marqueeConfig{
    
    self.keyFrame.duration = marqueeConfig.duration;
    self.imageView.alpha = 1;
    self.contentLab.text = marqueeConfig.contentText;
    self.contentLab.font = marqueeConfig.font;
    [self.contentLab sizeToFit];

    CGFloat sizeHeight = CGRectGetHeight(self.contentLab.frame);
    
    switch (marqueeConfig.direction) {
        case JobsMarqueeDirectionStyleTop:{
            self.keyFrame.keyPath = @"transform.translation.y";
            self.keyFrame.values = @[@(sizeHeight),@(0)];
        }break;
        case JobsMarqueeDirectionStyleDown:{
            self.keyFrame.keyPath = @"transform.translation.y";
            self.keyFrame.values = @[@(0), @(sizeHeight)];
        }break;
        case JobsMarqueeDirectionStyleLeft:{
            self.keyFrame.keyPath = @"transform.translation.x";
            self.keyFrame.values = @[@(self.bounds.size.width),@(0)];
        }break;
        case JobsMarqueeDirectionStyleRight:{
            self.keyFrame.keyPath = @"transform.translation.x";
            self.keyFrame.values = @[@(0), @(self.bounds.size.width)];
        }break;
            
        default:
            break;
    }
    [self.contentView.layer addAnimation:self.keyFrame
                                 forKey:@"keyFrame"];

}
#pragma mark —— lazyLoad
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = UIView.new;
        _contentView.backgroundColor = KGreenColor;
        [self addSubview:_contentView];
        _contentView.frame = self.bounds;
    }return _contentView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.backgroundColor = kRedColor;
        [self.contentView addSubview:_imageView];
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
        _contentLab.textColor = kBlueColor;
        [self.contentView addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.imageView.mas_right).offset(10);
        }];
    }return _contentLab;
}

-(CAKeyframeAnimation *)keyFrame{
    if (!_keyFrame) {
        _keyFrame = CAKeyframeAnimation.animation;
        _keyFrame.repeatCount = NSIntegerMax;
        _keyFrame.autoreverses = NO;
    }return _keyFrame;
}

@end
