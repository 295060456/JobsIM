//
//  JobsIMInputview.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "JobsIMInputview.h"

@interface JobsIMInputview ()

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)JobsAdNoticeView *adNoticeView;
@property(nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,copy)MKDataBlock jobsIMInputviewBlock;
@property(nonatomic,assign)BOOL isOK;
//data

@end

@implementation JobsIMInputview

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kWhiteColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.sendBtn.alpha = 1;
        self.inputTextField.alpha = 1;
        self.isOK = YES;
    }
}
//一些变化的UI
-(void)someChangeUI:(NSString *)string{
    if (![NSString isNullString:string]) {
        self.sendBtn.userInteractionEnabled = YES;
        self.sendBtn.enabled = YES;
        self.imgView.image = KIMG(@"输入框有值");
    }else{
        self.sendBtn.userInteractionEnabled = NO;
        self.sendBtn.enabled = NO;
        self.imgView.image = KIMG(@"输入框无值");
    }
}
#pragma mark —— UITextFieldDelegate
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [textField isEmptyText];
}
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];
    if (self.jobsIMInputviewBlock) {
        self.jobsIMInputviewBlock(textField);
    }return YES;
}

-(void)actionBlockJobsIMInputview:(MKDataBlock)jobsIMInputviewBlock{
    self.jobsIMInputviewBlock = jobsIMInputviewBlock;
}
#pragma mark —— lazyLoad
-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = UIButton.new;
        _sendBtn.userInteractionEnabled = NO;
        _sendBtn.enabled = NO;
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        [_sendBtn setTitleColor:kWhiteColor forState:UIControlStateDisabled];
        [_sendBtn setBackgroundImage:[UIImage imageWithColor:kCyanColor] forState:UIControlStateNormal];
        [_sendBtn setBackgroundImage:[UIImage imageWithColor:KLightGrayColor] forState:UIControlStateDisabled];
        @weakify(self)
        [[_sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            [self.inputTextField endEditing:YES];
            if (![NSString isNullString:self.inputTextField.text]) {
                [NSObject playSoundEffect:@"Sound"
                                     type:@"wav"];
                if (self.jobsIMInputviewBlock) {
                    self.jobsIMInputviewBlock(self.inputTextField);
                }
            }
            self.inputTextField.text = @"";
            x.enabled = NO;
        }];
        [self addSubview:_sendBtn];
        [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(11);
            make.bottom.equalTo(self).offset(-11);
            make.right.equalTo(self).offset(-10);
            make.width.mas_equalTo(50);
        }];
        [UIView cornerCutToCircleWithView:_sendBtn
                          andCornerRadius:3];
    }return _sendBtn;
}

-(ZYTextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = ZYTextField.new;
        _inputTextField.placeHolderAlignment = PlaceHolderAlignmentCenter;
        _inputTextField.placeholder = @"在此输入需要发送的信息";
        _inputTextField.delegate = self;
        _inputTextField.leftView = self.imgView;
        _inputTextField.ZYtextFont = [UIFont systemFontOfSize:12
                                           weight:UIFontWeightMedium];
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        _inputTextField.backgroundColor = HEXCOLOR(0xF4F4F4);
        _inputTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
        _inputTextField.autocorrectionType = UITextAutocorrectionTypeNo;//自动纠错属性默认是yes，就会触发那个监听
//        _inputTextField.inputAccessoryView = self.adNoticeView;
        _inputTextField.returnKeyType = UIReturnKeySend;
        [self addSubview:_inputTextField];
        [_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.sendBtn);
            make.right.equalTo(self.sendBtn.mas_left).offset(-10);
            make.left.equalTo(self).offset(10);
        }];

        [self layoutIfNeeded];
        
        [UIView cornerCutToCircleWithView:_inputTextField
                          andCornerRadius:_inputTextField.mj_h / 2];
        [UIView colourToLayerOfView:_inputTextField
                         withColour:kWhiteColor
                     andBorderWidth:1];
        
        @weakify(self)
        [_inputTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            NSLog(@"MMM = %@",x);
            [self someChangeUI:x];
        }];
    }return _inputTextField;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = UIImageView.new;
        _imgView.image = KIMG(@"输入框无值");
    }return _imgView;
}

-(JobsAdNoticeView *)adNoticeView{
    if (!_adNoticeView) {
        _adNoticeView = JobsAdNoticeView.new;
        _adNoticeView.size = _adNoticeView.makeSize;
    }return _adNoticeView;
}

@end
