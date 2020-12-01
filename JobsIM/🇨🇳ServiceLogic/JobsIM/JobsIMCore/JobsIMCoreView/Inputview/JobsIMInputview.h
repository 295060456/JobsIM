//
//  JobsIMInputview.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import "UIImage+Extras.h"
#import "PlaySound.h"//播放自定义声音关键代码

NS_ASSUME_NONNULL_BEGIN

@interface JobsIMInputview : UIView

@property(nonatomic,strong)ZYTextField *inputTextField;

-(void)someChangeUI:(NSString *)string;//一些变化的UI
-(void)actionBlockJobsIMInputview:(MKDataBlock)jobsIMInputviewBlock;

@end

NS_ASSUME_NONNULL_END
