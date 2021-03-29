//
//  JobsIMInputview.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import "NSObject+Sound.h"
#import "UIImage+Extras.h"
#import "ZYTextField.h"
#import "JobsAdNoticeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsIMInputview : UIView<UITextFieldDelegate>

@property(nonatomic,strong)ZYTextField *inputTextField;

-(void)someChangeUI:(NSString *)string;//一些变化的UI
-(void)actionBlockJobsIMInputview:(MKDataBlock)jobsIMInputviewBlock;

@end

NS_ASSUME_NONNULL_END
