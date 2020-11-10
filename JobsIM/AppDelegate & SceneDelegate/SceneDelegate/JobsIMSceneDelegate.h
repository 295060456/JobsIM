//
//  JobsIMSceneDelegate.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <UIKit/UIKit.h>

@interface JobsIMSceneDelegate : UIResponder <UIWindowSceneDelegate>

@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)UIWindowScene *windowScene;

+(instancetype)sharedInstance;

@end

