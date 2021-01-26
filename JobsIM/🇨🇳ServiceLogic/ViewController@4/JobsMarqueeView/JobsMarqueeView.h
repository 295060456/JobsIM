//
//  JobsMarqueeView.h
//  JobsIM
//
//  Created by Jobs on 2021/1/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    JobsMarqueeDirectionStyleTop = 0,//滚动方向：垂直上↑
    JobsMarqueeDirectionStyleDown,//滚动方向：垂直下↓
    JobsMarqueeDirectionStyleLeft,//滚动方向：水平左←
    JobsMarqueeDirectionStyleRight,//滚动方向：水平右→
} JobsMarqueeDirectionStyle;

@interface JobsMarqueeConfig : NSObject

@property(nonatomic,assign)CFTimeInterval duration;
@property(nonatomic,copy)NSString *contentText;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,assign)JobsMarqueeDirectionStyle direction;

@end

@interface JobsMarqueeView : UIView

-(void)richElementsWithModel:(JobsMarqueeConfig *_Nullable)model;

-(void)richElementsWithModel:(JobsMarqueeConfig *_Nullable)marqueeConfig
                  customView:(MKDataBlock)marqueeViewBlock;

@end

NS_ASSUME_NONNULL_END
