//
//  JobsCommentAppDelegate.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TabbarVC.h"
#import "NoticePopupView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@interface JobsCommentAppDelegate : UIResponder <UIApplicationDelegate>

@property(readonly,strong)NSPersistentCloudKitContainer *persistentContainer;
@property(nonatomic,strong)UIWindow *window;//仅仅为了iOS 13 版本向下兼容而存在
@property(nonatomic,strong)TabbarVC *tabBarVC;
@property(nonatomic,strong)NoticePopupView *popupView;

-(void)saveContext;
+(instancetype)sharedInstance;

@end

#pragma clang diagnostic pop
