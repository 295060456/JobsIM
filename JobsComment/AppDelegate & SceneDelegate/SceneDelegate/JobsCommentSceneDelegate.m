//
//  JobsIMJobsIMSceneDelegate.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "JobsCommentSceneDelegate.h"
#import "JobsCommentAppDelegate.h"
#import "JobsCommentAppDelegate+PopupView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@interface JobsCommentSceneDelegate ()

@end

@implementation JobsCommentSceneDelegate

static JobsCommentSceneDelegate *static_JobsCommentSceneDelegate = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_JobsCommentSceneDelegate) {
            static_JobsCommentSceneDelegate = JobsCommentSceneDelegate.new;
        }
    }return static_JobsCommentSceneDelegate;
}

-(instancetype)init{
    if (self = [super init]) {
        static_JobsCommentSceneDelegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(noti1:)
                                                     name:UISceneWillConnectNotification
                                                   object:nil];
    }return self;
}

-(void)noti1:(NSNotification *)notification{
    self.windowScene = notification.object;
}

- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
      options:(UISceneConnectionOptions *)connectionOptions {
    
    //在这里手动创建新的window
    if (@available(iOS 13.0, *)) {
        self.windowScene = (UIWindowScene *)scene;
        XHLaunchAd * ad = [XHLaunchAd setWaitDataDuration:10];
        [ad scene:self.windowScene];
        self.window.alpha = 1;
        [[JobsCommentAppDelegate sharedInstance] Popupview];// 弹出框
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"---applicationDidBecomeActive----");//进入前台
}

- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"---applicationDidEnterBackground----"); //进入后台
    [(JobsCommentAppDelegate *)UIApplication.sharedApplication.delegate saveContext];
    [[NSNotificationCenter defaultCenter] postNotificationName:UBLEnterBackgroundStopPlayer object:nil];
}
#pragma mark —— lazyLoad
-(UIWindow *)window{
    [_window setRootViewController:JobsCommentAppDelegate.sharedInstance.tabBarVC];
    [_window makeKeyAndVisible];
    return _window;
}

@end

#pragma clang diagnostic pop
