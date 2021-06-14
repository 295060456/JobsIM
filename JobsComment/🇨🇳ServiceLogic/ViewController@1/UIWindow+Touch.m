//
//  UIWindow+Touch.m
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import "UIWindow+Touch.h"

@implementation UIWindow (Touch)

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    extern PopUpVC *popUpVC;
    if (popUpVC) {
        [popUpVC dismissViewControllerAnimated:YES
                                    completion:Nil];
    }
    
    extern JobsCommentCoreVC *jobsCommentCoreVC;
    if (jobsCommentCoreVC) {
        [jobsCommentCoreVC dismissViewControllerAnimated:YES
                                              completion:Nil];
    }
}

@end
