//
//  AppDelegate.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "NoticePopupView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(readonly,strong)NSPersistentCloudKitContainer *persistentContainer;
@property(nonatomic,strong)UIWindow *window;//仅仅为了iOS 13 版本向下兼容而存在
@property(nonatomic,strong)TabbarVC *tabbarVC;
@property(nonatomic,strong)NoticePopupView *popupView;

-(void)saveContext;
+(AppDelegate *)sharedInstance;


@end

